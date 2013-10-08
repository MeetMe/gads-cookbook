#
# Cookbook Name:: gads
# Recipe:: default
#
# Copyright 2013, MeetMe, Inc.
#
include_recipe  'run_once::default'

# Required for the interactive installation and encryption
%w[greenletters httparty].each do |gem_name|
  chef_gem gem_name
end

user 'gads' do
  action  :create
  home    node[:gads][:install_path]
  system  true
end

# This is run if gads has previously been installed
gads_config node[:gads][:config_path] do
  only_if       {RunOnce.had_run?(node, :gads, :installed)}
  owner         'gads'
end

# Install GADS if it's not been installed yet
gads_install node[:gads][:install_path] do
  not_if         {RunOnce.had_run?(node, :gads, :installed)}
  owner          'gads'
  symlinks       node[:gads][:create_symlinks]
  symlinks_path  node[:gads][:symlinks_path]
  notifies       :create, "gads_config[#{node[:gads][:config_path]}]"
end

# This is run the first time through, triggered by the install
gads_config node[:gads][:config_path] do
  action        :nothing
  owner         'gads'
end
