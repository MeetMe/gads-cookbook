require 'greenletters'

class Chef::Recipe::GADS

  def self.encrypted_value(field_name)

    # Regex to match the output
    encrypted_output = /Encrypted\svalue\s\(case\ssensitive,\splease\scut\sand paste\)\:\s([\w\S]+)/i

    # Encrypt the LDAP password
    encrypt = Greenletters::Process.new("#{node[:gads][:install_path]}/encrypt-util -c #{node[:gads][:config_path]}",
                                        :timeout => 10, :transcript => $stdout)
    encrypt.on(:output, encrypted_output) do |process, match_data|
      # Unfortunately I could not find the match group in match_data
      encrypted = match_data.matched.match(encrypted_output)
      Chef::Log.info("Encrypted value: #{encrypted[1]}")
      return encrypted[1]
    end
    encrypt_ldap.start!
    encrypt_ldap.wait_for(:output, /Please enter the value to encrypt for the specified config/i)
    encrypt_ldap << "#{field_name}\n"
    encrypt_ldap.wait_for(:exit)
  end

end