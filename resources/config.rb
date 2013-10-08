actions :create
default_action :create

attribute :config_path, :kind_of => String, :default => '/usr/local/etc/gads.xml', :name_attribute => true
attribute :owner, :kind_of => String, :default => 'gads'
attribute :group, :kind_of => String, :default => 'root'
attr_accessor :gads_version, :config_hash, :template_finder, :chef_version