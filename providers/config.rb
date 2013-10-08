use_inline_resources

action :create do
  new_resource.config_hash = generate_config_hash
  new_resource.gads_version = fetch_gads_version
  new_resource.template_finder = Chef::Provider::TemplateFinder.new(@run_context, 'gads', node)
  generate_encrypted_config(get_encrypted_passwords)
end

private

require 'tempfile'
require 'chef/mixin/template'
require 'chef/provider/template_finder'
include Chef::Mixin::ShellOut
include Chef::Mixin::Template

def fetch_gads_version
  response = shell_out("#{node[:gads][:install_path]}/sync-cmd -v")
  response.stdout.to_s[8,8].strip!
end

def generate_config_hash
  Digest::MD5.hexdigest(JSON.dump(node[:gads].to_hash))
end

def generate_encrypted_config(values)
  values[:gads_version] = new_resource.gads_version
  values[:config_hash] = new_resource.config_hash
  t = template new_resource.config_path do
    source 'encrypted.xml.erb'
    owner  new_resource.owner
    group  new_resource.group
    mode   0600
    variables(values)
  end
  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

def get_encrypted_passwords
  render_with_context(new_resource.template_finder.find('unencrypted.xml.erb')) do |rendered_template|
    admin_encrypted = get_encrypted_value(rendered_template.path, node[:gads][:google][:admin_password])
    ldap_encrypted = get_encrypted_value(rendered_template.path, node[:gads][:ldap][:auth_password])
    ::File.unlink(rendered_template.path)
    {:admin_password => admin_encrypted, :ldap_password => ldap_encrypted}
  end
end

module MonkeyProcess
  def process_interruption(reason)
    if blocked?
      self.interruption = reason
      unblock!
    end
  end
end

def get_encrypted_value(path, value)
  require 'greenletters'

  encrypted_value = nil
  encrypted_output = /Encrypted\svalue\s\(case\ssensitive,\splease\scut\sand paste\)\:\s([\w\S]+)/i

  ## Stupid monkeypatch to get around the fact that GADS encrypt-util hangs when trying to phone home for updates
  encrypt = Greenletters::Process.new("su gads -c '#{node[:gads][:install_path]}/encrypt-util -c #{path}'",
                                      :timeout => 10, :transcript => $stdout).extend(MonkeyProcess)

  encrypt.on(:output, encrypted_output) do |process, match_data|
    encrypted = match_data.matched.match(encrypted_output)
    encrypted_value = encrypted[1]
    encrypt.kill!('KILL')
  end
  encrypt.start!
  encrypt.wait_for(:output, /Please enter the value to encrypt for the specified config/i)
  encrypt << "#{value}\n"
  encrypt.wait_for(:exit)
  Chef::Log.debug("Encrypted value: #{encrypted_value}")
  encrypted_value
end

def render_with_context(template_location, &block)
  if node[:chef_packages][:chef][:version][0,5].eql? '11.6.'
    context = TemplateContext.new({:config_hash => new_resource.config_hash,
                                   :gads_version => new_resource.gads_version})
    context[:node] = node
    context[:template_finder] = new_resource.template_finder
    output = context.render_template(template_location)
    Tempfile.open("chef-rendered-template") do |tempfile|
      tempfile.print(output)
      tempfile.close
      ::File.chmod(0644, tempfile)
      yield tempfile
    end
  elsif node[:chef_packages][:chef][:version][0,5].eql? '11.4.'
    context = {}
    context.merge!({:config_hash => new_resource.config_hash,
                    :gads_version => new_resource.gads_version})
    render_template(IO.read(template_location), context, &block)
  else
    Chef::Log.error("Could not render the temp file, unknown Chef version #{node[:chef_packages][:chef][:version0][0,5]}")
  end
end