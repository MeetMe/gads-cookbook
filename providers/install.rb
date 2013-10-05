include Chef::Mixin::ShellOut

action :install do
  require 'greenletters'
  require 'httparty'

  Chef::Log.info('Downloading latest GADS installer from Google')
  response = HTTParty.get(node[:gads][:download_url])
  open new_resource.installer_path, 'w' do |io|
    io.write response.body
    io.chmod(0755)
  end

  Chef::Log.info('Running installer')
  run_installer

  # Change the file permissions of the install
  shell_out!("chown -R #{new_resource.owner}:#{new_resource.group} #{new_resource.directory}")

  # Set the Run Flag indicating it was installed
  RunOnce.ran(node, :gads, :installed)

  # Notify it was updated by last action
  new_resource.updated_by_last_action(true)
end


def run_installer
    # Greenletters process will abort if it can't install after 60 seconds, send output to STDOUT
    install = Greenletters::Process.new(new_resource.installer_path,
                                        :timeout => 60,
                                        :transcript => $stdout)

    # Async trigger that will keep us from having to count [More] prompts (8) in the license display
    install.on(:output, /^\[Enter\]\r\n/i) do |process, match_data|
      Chef::Log.info('Pressing enter on license paging')
      install << "\n"
    end

    # Start the process
    install.start!

    # Wait for the install start prompt
    wait_and_respond(install, /OK \[o, Enter\], Cancel \[c\]/i, 'o')
    Chef::Log.debug('Received install start prompt')

    # Wait for the license acceptance prompt, the license paging is handled by the async trigger above
    wait_and_respond(install, /Yes \[1\], No \[2\]/i, '1')
    Chef::Log.debug('Accepted License')

    # Wait for the prompt for where to install
    wait_and_respond(install, /Where should Google Apps Directory Sync be installed?/i, new_resource.directory)
    Chef::Log.debug('Received install path prompt')

    # Wait for symlinks creation prompt
    create_symlinks = new_resource.symlinks ? 'y' : 'n'
    Chef::Log.debug("Create_symlinks: #{create_symlinks}")
    wait_and_respond(install, /Create symlinks?/i, create_symlinks)
    Chef::Log.debug('Received symlinks prompt')

    # Wait for symlink path folder prompt
    wait_and_respond(install, /Select the folder where you would like Google Apps Directory Sync to create symlinks/i, new_resource.symlinks_path)
    Chef::Log.debug('Received symlinks path prompt')

    # Wait for process to finish
    install.wait_for(:exit)
end


# Cut down on a repetitive two line step
def wait_and_respond(process, pattern, response)
  process.wait_for(:output, pattern)
  process << "#{response}\n"
end
