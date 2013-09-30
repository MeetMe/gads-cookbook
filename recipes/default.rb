#
# Cookbook Name:: gads
# Recipe:: default
#
# Copyright 2013, MeetMe, Inc.
#
installer_path = '/tmp/gads-installer.sh'

user 'gads' do
  action  :create
  home    node[:gads][:install_path]
  system  true
end

ruby_block 'install-gads' do
  action :nothing
  only_if {File::exists?(installer_path)}
  not_if { node.attribute?(:run_flags) && node.attribute?(:run_flags) && node[:run_flags][:gads_installed] }
  block do
    require 'greenletters'

    # Greenletters process will abort if it can't install after 60 seconds, send output to STDOUT
    install = Greenletters::Process.new(installer_path, :timeout => 120, :transcript => $stdout)

    # Async trigger that will keep us from having to count [More] prompts (8) in the license display
    install.on(:output, /^\[Enter\]\r\n/i) do |process, match_data|
      Chef::Log.info('Pressing enter on license paging')
      install << "\n"
    end

    # Start the process
    install.start!

    # Wait for the install start prompt
    install.wait_for(:output, /OK \[o, Enter\], Cancel \[c\]/i)
    Chef::Log.info('Received install start prompt')
    install << "o\n"

    # Wait for the license acceptance prompt, the license paging is handled by the async trigger above
    install.wait_for(:output, /Yes \[1\], No \[2\]/i)
    Chef::Log.info('Received agreement acceptance prompt')
    install << "1\n"

    # Wait to be prompted for where GADS should be installed
    install.wait_for(:output, /Where should Google Apps Directory Sync be installed?/i)
    Chef::Log.info('Received install path prompt')
    install << "#{node[:gads][:install_path]}\n"

    # Wait for symlinks creation prompt
    install.wait_for(:output, /Create symlinks?/i)
    Chef::Log.info('Received symlinks prompt')
    if node[:gads][:create_symlinks]
      install << "y\n"
    else
      install << "n\n"
    end

    # Wait for symlink path folder prompt
    install.wait_for(:output, /Select the folder where you would like Google Apps Directory Sync to create symlinks/i)
    Chef::Log.info('Received symlinks path prompt')
    install << "#{node[:gads][:synlinks_path]}\n"

    # Wait for process to finish
    install.wait_for(:exit)

    node.set[:run_flags][:gads_installed] = true
  end
  notifies :create, "ruby_block[encrypt_config]"
end

template node[:gads][:config_path] do
  not_if { node.attribute?(:run_flags) && node.attribute?(:run_flags) && node[:run_flags][:gads_pwds_encrypted] }
  action :create
  source 'gads.xml.erb'
  owner  'gads'
  mode   0644
end

ruby_block 'encrypt_config' do
  action :nothing
  not_if { node.attribute?(:run_flags) && node.attribute?(:run_flags) && node[:run_flags][:gads_pwds_encrypted] }
  block do
    require 'greenletters'

    # The output line that has the password
    encrypted_output = /Encrypted\svalue\s\(case\ssensitive,\splease\scut\sand paste\)\:\s([\w\S]+)/i

    # Encrypt the admin password
    encrypt_auth = Greenletters::Process.new("#{node[:gads][:install_path]}/encrypt-util -c #{node[:gads][:config_path]}",
                                             :timeout => 10, :transcript => $stdout)
    encrypt_auth.on(:output, encrypted_output) do |process, match_data|
      # Unfortunately I could not find the match group in match_data
      encrypted = match_data.matched.match(encrypted_output)
      node.override[:gads][:google][:admin_password] = encrypted[1]
    end
    encrypt_auth.start!
    encrypt_auth.wait_for(:output, /Please enter the value to encrypt for the specified config/i)
    encrypt_auth << "encryptedAdminPassword\n"
    encrypt_auth.wait_for(:exit)

    # Encrypt the LDAP password
    encrypt_ldap = Greenletters::Process.new("#{node[:gads][:install_path]}/encrypt-util -c #{node[:gads][:config_path]}",
                                             :timeout => 10, :transcript => $stdout)
    encrypt_ldap.on(:output, encrypted_output) do |process, match_data|
      # Unfortunately I could not find the match group in match_data
      encrypted = match_data.matched.match(encrypted_output)
      node.override[:gads][:ldap][:auth_password] = encrypted[1]
    end
    encrypt_ldap.start!
    encrypt_ldap.wait_for(:output, /Please enter the value to encrypt for the specified config/i)
    encrypt_ldap << "authCredentialsEncrypted\n"
    encrypt_ldap.wait_for(:exit)

    # Set the flag that passwords have been encrypted
    node.set[:run_flags][:gads_passwords_encrypted] = true
  end

  # Re-Create the config file once the new values are overwritten
  notifies :create, "template[#{node[:gads][:config_path]}]"
end

# Download and install the GADs installer if it's not already been done
remote_file installer_path do
  not_if { node.attribute?(:run_flags) && node.attribute?(:run_flags) && node[:run_flags][:gads_installed] }
  action :nothing
  source node[:gads][:download_url]
  mode   0744
  notifies :create, 'ruby_block[install-gads]'
end

# Required for the interactive installation and encryption
chef_gem 'greenletters' do
  notifies :create, "remote_file[#{installer_path}]", :immediately
end
