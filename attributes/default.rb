# Installation Options
default[:gads][:download_url] = 'http://dl.google.com/dirsync/google/googleappsdirsync_linux_64bit_3_2_1.sh'
default[:gads][:create_symlinks] = true
default[:gads][:install_path] = '/opt/GoogleAppsDirSync'
default[:gads][:symlinks_path] = '/usr/local/bin'
default[:gads][:config_path] = '/usr/local/etc/gads.xml'

# Features
default[:gads][:features] = %w[ALIAS_SYNCHRONIZATION
                               CACHE_PASSWORD_TIMESTAMPS
                               FAMILY_NAME
                               GIVEN_NAME
                               GOOGLE_ORGUNITS
                               GOOGLE_QUOTA
                               GROUPS
                               GROUP_DESCRIPTION
                               GROUP_OWNER
                               MULTIDOMAIN
                               NON_ADDRESS_PRIMARY_KEY
                               SHA1_PASSWORD
                               SHARED_CONTACTS
                               SKIP_CALENDAR_RESOURCES
                               SKIP_SUSPENDING_ADMINS
                               SUSPEND_USERS
                               USER_PROFILES]

# Logging
default[:gads][:logging][:file] = '/var/log/google/gads.log'
default[:gads][:logging][:format] = '[%d{ISO8601}] [%t] [%p] [%C{3}] %m%n'
default[:gads][:logging][:level] = 'INFO'
default[:gads][:logging][:max_bytes] = 4294967296
default[:gads][:logging][:max_files] = 1

# Email Notifications
default[:gads][:notification][:smtp_relay] = 'localhost'
default[:gads][:notification][:from_address] = 'gads@yourdomain.com'
default[:gads][:notification][:to_address] = 'you@yourdomain.com'
default[:gads][:notification][:ignore_errors] = false
default[:gads][:notification][:ignore_info] = false
default[:gads][:notification][:ignore_warnings] = false

# Limits
default[:gads][:limit][:delete_calendar_percent] = 5
default[:gads][:limit][:delete_contact_percent] = 5
default[:gads][:limit][:delete_group_percent] = 5
default[:gads][:limit][:delete_ou_percent] = 5
default[:gads][:limit][:delete_user_percent] = 5
default[:gads][:limit][:suspend_user_percent] = 5

# Cache Lifetime
default[:gads][:cache_lifetime] = 691200

# Google Settings
default[:gads][:google][:admin_email] = 'you@your-gapps-domain.com'
default[:gads][:google][:admin_password] = 'your-password-value'
default[:gads][:google][:domain] = 'your-gapps-domain.com'
default[:gads][:google][:threads][:contact_sync] = 15
default[:gads][:google][:threads][:profile_sync] = 30
default[:gads][:google][:threads][:user_sync] = 30

# Make the config id the md5 of the domain
require 'digest/md5'
default[:gads][:config_id] = Digest::MD5.hexdigest(node[:gads][:google][:domain])

# Exclude List -- set as a role attribute, valid values for match and type are in the Google Apps admin guide
default[:gads][:google][:exclude] = []
#  {:match => 'USER_NAME',
#   :type =>  'EXACT',
#   :filter => 'foo@bar.com'},
#  {:match => 'USER_NAME',
#   :type => 'SUBSTRING',
#   :filter => 'txt.att.net'},
#  {:match => 'GROUP_NAME',
#   :type => 'EXACT',
#   :filter => 'gapps-only-group@your-gapps-domain.com'}]

# LDAP Settings
default[:gads][:ldap][:type] = 'OPENLDAP'
default[:gads][:ldap][:connect_method] = 'STANDARD'
default[:gads][:ldap][:hostname] = 'your-ldap-server'
default[:gads][:ldap][:port] = 389
default[:gads][:ldap][:basedn] = 'dc=foo,dc=com'
default[:gads][:ldap][:auth_type] = 'SIMPLE'
default[:gads][:ldap][:auth_user] = 'cn=Manager,dc=foo,dc=com'
default[:gads][:ldap][:auth_password] = 'bind dn password value'
default[:gads][:ldap][:attr][:email] = 'mail'
default[:gads][:ldap][:attr][:email_alias] = 'mailLocalAddress'
default[:gads][:ldap][:attr][:given_name] = 'givenName'
default[:gads][:ldap][:attr][:family_name] = 'sn'
default[:gads][:ldap][:attr][:sha1_password] = 'userPassword'
default[:gads][:ldap][:attr][:password_last_set] = 'pwdChangedTime'
default[:gads][:ldap][:generated_password_length] = 8
default[:gads][:ldap][:results_page_size] = 1000

default[:gads][:ldap][:groups][:search][:priority] = 1
default[:gads][:ldap][:groups][:search][:basedn] = "ou=Groups,#{node[:gads][:ldap][:basedn]}"
default[:gads][:ldap][:groups][:search][:scope] = 'SUBTREE'
default[:gads][:ldap][:groups][:search][:filter] = 'objectClass=groupOfNames'
default[:gads][:ldap][:groups][:search][:attr][:description] = 'description'
default[:gads][:ldap][:groups][:search][:attr][:display_name] = 'cn'
default[:gads][:ldap][:groups][:search][:attr][:member] = 'member'
default[:gads][:ldap][:groups][:search][:attr][:name] = 'mailRoutingAddress'
default[:gads][:ldap][:groups][:search][:attr][:owner_dn] = 'owner'
default[:gads][:ldap][:groups][:search][:attr][:user_email] = 'mail'

default[:gads][:ldap][:orgunits][:mapping][:dn] = "ou=People,#{node[:gads][:ldap][:basedn]}"
default[:gads][:ldap][:orgunits][:mapping][:name] = '/'
default[:gads][:ldap][:orgunits][:search][:priority] = 1
default[:gads][:ldap][:orgunits][:search][:basedn] = "ou=People,#{node[:gads][:ldap][:basedn]}"
default[:gads][:ldap][:orgunits][:search][:scope] = 'SUBTREE'
default[:gads][:ldap][:orgunits][:search][:filter] = 'objectClass=organizationalUnit'
default[:gads][:ldap][:orgunits][:search][:attr][:description] = 'ou'

default[:gads][:ldap][:users][:search][:priority] = 1
default[:gads][:ldap][:users][:search][:basedn] = "ou=People,#{node[:gads][:ldap][:basedn]}"
default[:gads][:ldap][:users][:search][:suspended] = false
default[:gads][:ldap][:users][:search][:scope] = 'SUBTREE'
default[:gads][:ldap][:users][:search][:filter] = 'objectClass=inetOrgPerson'
default[:gads][:ldap][:users][:search][:attr][:org_mapping] = ''
default[:gads][:ldap][:users][:search][:attr][:company_name] = 'o'
default[:gads][:ldap][:users][:search][:attr][:department] = 'department'
default[:gads][:ldap][:users][:search][:attr][:title] = 'title'
default[:gads][:ldap][:users][:search][:attr][:full_name] = 'displayName'
default[:gads][:ldap][:users][:search][:attr][:assistant] = 'secretary'
default[:gads][:ldap][:users][:search][:attr][:manager] = 'manager'
default[:gads][:ldap][:users][:search][:attr][:sync_key] = 'cn'
default[:gads][:ldap][:users][:search][:attr][:street_address] = 'street'
default[:gads][:ldap][:users][:search][:attr][:pobox] = 'postOfficeBox'
default[:gads][:ldap][:users][:search][:attr][:city] = 'l'
default[:gads][:ldap][:users][:search][:attr][:state] = 'st'
default[:gads][:ldap][:users][:search][:attr][:postal_code] = 'postalCode'
default[:gads][:ldap][:users][:search][:attr][:email] = 'mail'
default[:gads][:ldap][:users][:search][:attr][:employee_id] = 'employeeNumber'
default[:gads][:ldap][:users][:search][:attr][:fax] = 'faxsimileTelephoneNumber'
default[:gads][:ldap][:users][:search][:attr][:home_phone] = 'homePhone'
default[:gads][:ldap][:users][:search][:attr][:mobile_phone] = 'mobile'
default[:gads][:ldap][:users][:search][:attr][:work_phone] = 'telephoneNumber'
default[:gads][:ldap][:users][:search][:attr][:description] = 'description'
default[:gads][:ldap][:users][:search][:attr][:office_location] = 'physicalDeliveryOfficeName'
