actions :install
default_action :install

attribute :directory, :kind_of => String, :default => '/opt/GoogleAppsDirSync', :name_attribute => true
attribute :symlinks, :kind_of => [TrueClass, FalseClass], :default => true
attribute :symlinks_path, :kind_of => String, :default => '/usr/local/bin'
attribute :installer_path, :kind_of => String, :default => '/tmp/gads-installer.sh'
attribute :owner, :kind_of => String, :default => 'gads'
attribute :group, :kind_of => String, :default => 'root'