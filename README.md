Google Apps Directory Sync Cookbook
===================================
Installs and configures Google Apps Directory Sync in a Linux environment

Requirements
------------
The gads::default cookbook will install the one dependency gem, greenletters which is used to automate interaction with the installation script and the password encryption script.

#### cookbooks
- `java` - Java is required to run Google App Directory Sync. The gads::default recipe installs using the default behavior. Include java in your runlist prior to gads if you want to change the install behavior.

Attributes
----------

#### gads::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
<tr><td><tt>[:gads][:download_url]</tt></td><td>String</td><td></td><td><tt>http://dl.google.com/dirsync/dirsync-linux64.sh</tt></td></tr>
<tr><td><tt>[:gads][:create_symlinks]</tt></td><td>Boolean</td><td></td><td><tt>true</tt></td></tr>
<tr><td><tt>[:gads][:install_path]</tt></td><td>String</td><td></td><td><tt>/opt/GoogleAppsDirSync</tt></td></tr>
<tr><td><tt>[:gads][:synlinks_path]</tt></td><td>String</td><td></td><td><tt>/usr/local/bin</tt></td></tr>
<tr><td><tt>[:gads][:config_path]</tt></td><td>String</td><td></td><td><tt>/usr/local/etc/gads.xml</tt></td></tr>
<tr><td><tt>[:gads][:config_version]</tt></td><td>String</td><td></td><td><tt>3.1.6</tt></td></tr>
tr><td><tt>[:gads][:features]</tt></td><td>Array</td><td></td><td>
 - CACHE_PASSWORD_TIMESTAMPS
 - ALIAS_SYNCHRONIZATION
 - USER_PROFILES
 - SKIP_CALENDAR_RESOURCES
 - GROUP_DESCRIPTION
 - GROUP_OWNER
 - SUSPEND_USERS
 - NON_ADDRESS_PRIMARY_KEY
 - GOOGLE_ORGUNITS
 - SHA1_PASSWORD
 - MULTIDOMAIN
 - SKIP_SUSPENDING_ADMINS
 - FAMILY_NAME
 - GIVEN_NAME
 - SHARED_CONTACTS
 - GROUPS
</tt></td></tr>
<tr><td><tt>[:gads][:logging][:file]</tt></td><td>String</td><td></td><td><tt>/var/log/google/gads.log</tt></td></tr>
<tr><td><tt>[:gads][:logging][:format]</tt></td><td>String</td><td></td><td><tt>[%d{ISO8601}] [%t] [%p] [%C{3}] %m%n</tt></td></tr>
<tr><td><tt>[:gads][:logging][:level]</tt></td><td>String</td><td></td><td><tt>INFO</tt></td></tr>
<tr><td><tt>[:gads][:logging][:max_bytes]</tt></td><td>Number</td><td></td><td><tt>4294967296</tt></td></tr>
<tr><td><tt>[:gads][:logging][:max_files]</tt></td><td>Number</td><td></td><td><tt>1</tt></td></tr>
<tr><td><tt>[:gads][:notification][:smtp_relay]</tt></td><td>String</td><td></td><td><tt>localhost</tt></td></tr>
<tr><td><tt>[:gads][:notification][:from_address]</tt></td><td>String</td><td></td><td><tt>gads@yourdomain.com</tt></td></tr>
<tr><td><tt>[:gads][:notification][:to_address]</tt></td><td>String</td><td></td><td><tt>you@yourdomain.com</tt></td></tr>
<tr><td><tt>[:gads][:notification][:ignore_errors]</tt></td><td>Boolean</td><td></td><td><tt>false</tt></td></tr>
<tr><td><tt>[:gads][:notification][:ignore_info]</tt></td><td>Boolean</td><td></td><td><tt>false</tt></td></tr>
<tr><td><tt>[:gads][:notification][:ignore_warnings]</tt></td><td>Boolean</td><td></td><td><tt>false</tt></td></tr>
<tr><td><tt>[:gads][:limit][:delete_calendar_percent]</tt></td><td>Number</td><td></td><td><tt>5</tt></td></tr>
<tr><td><tt>[:gads][:limit][:delete_contact_percent]</tt></td><td>Number</td><td></td><td><tt>5</tt></td></tr>
<tr><td><tt>[:gads][:limit][:delete_group_percent]</tt></td><td>Number</td><td></td><td><tt>5</tt></td></tr>
<tr><td><tt>[:gads][:limit][:delete_ou_percent]</tt></td><td>Number</td><td></td><td><tt>5</tt></td></tr>
<tr><td><tt>[:gads][:limit][:delete_user_percent]</tt></td><td>Number</td><td></td><td><tt>5</tt></td></tr>
<tr><td><tt>[:gads][:limit][:suspend_user_percent]</tt></td><td>Number</td><td></td><td><tt>5</tt></td></tr>
<tr><td><tt>[:gads][:cache_lifetime]</tt></td><td>Number</td><td></td><td><tt>691200</tt></td></tr>
<tr><td><tt>[:gads][:google][:admin_email]</tt></td><td>String</td><td></td><td><tt>you@your-gapps-domain.com</tt></td></tr>
<tr><td><tt>[:gads][:google][:admin_password]</tt></td><td>String</td><td></td><td><tt>your-password-value</tt></td></tr>
<tr><td><tt>[:gads][:google][:domain]</tt></td><td>String</td><td></td><td><tt>your-gapps-domain.com</tt></td></tr>
<tr><td><tt>[:gads][:google][:threads][:contact_sync]</tt></td><td>Number</td><td></td><td><tt>15</tt></td></tr>
<tr><td><tt>[:gads][:google][:threads][:profile_sync]</tt></td><td>Number</td><td></td><td><tt>30</tt></td></tr>
<tr><td><tt>[:gads][:google][:threads][:user_sync]</tt></td><td>Number</td><td></td><td><tt>30</tt></td></tr>
<tr><td><tt>[:gads][:google][:exclude]</tt></td><td>Array</td><td>Exclude List -- set as a role attribute, valid values for match and type are in the Google Apps admin guide</td><td>
   {:match => 'USER_NAME',
    :type =>  'EXACT',
    :filter => 'foo@bar.com'},
   {:match => 'USER_NAME',
    :type => 'SUBSTRING',
    :filter => 'txt.att.net'},
   {:match => 'GROUP_NAME',
    :type => 'EXACT',
    :filter => 'gapps-only-group@your-gapps-domain.com'}
</td></tr>

<tr><td><tt>[:gads][:ldap][:type]</tt></td><td>String</td><td></td><td><tt>OPENLDAP</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:connect_method]</tt></td><td>String</td><td></td><td><tt>STANDARD</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:hostname]</tt></td><td>String</td><td></td><td><tt>your-ldap-server</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:port]</tt></td><td>Number</td><td></td><td><tt>389</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:basedn]</tt></td><td>String</td><td></td><td><tt>dc=foo,dc=com</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:auth_type]</tt></td><td>String</td><td></td><td><tt>SIMPLE</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:auth_user]</tt></td><td>String</td><td></td><td><tt>cn=Manager,dc=foo,dc=com</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:auth_password]</tt></td><td>String</td><td></td><td><tt>bind</tt></td></tr> dn password value'
<tr><td><tt>[:gads][:ldap][:primary_key]</tt></td><td>String</td><td></td><td><tt>cn</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:attr][:email]</tt></td><td>String</td><td></td><td><tt>mail</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:attr][:email_alias]</tt></td><td>String</td><td></td><td><tt>mailLocalAddress</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:attr][:given_name]</tt></td><td>String</td><td></td><td><tt>givenName</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:attr][:family_name]</tt></td><td>String</td><td></td><td><tt>sn</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:attr][:sha1_password]</tt></td><td>String</td><td></td><td><tt>userPassword</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:attr][:password_last_set]</tt></td><td>String</td><td></td><td><tt>pwdChangedTime</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:generated_password_length]</tt></td><td>Number</td><td></td><td><tt>8</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:results_page_size]</tt></td><td>Number</td><td></td><td><tt>1000</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:groups][:search][:priority]</tt></td><td>Number</td><td></td><td><tt>1</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:groups][:search][:basedn]</tt></td><td>String</td><td></td><td><tt>"ou=Groups,#{node[:gads][:ldap][:basedn]}"</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:groups][:search][:scope]</tt></td><td>String</td><td></td><td><tt>SUBTREE</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:groups][:search][:filter]</tt></td><td>String</td><td></td><td><tt>objectClass=groupOfNames</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:groups][:search][:attr][:description]</tt></td><td>String</td><td></td><td><tt>description</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:groups][:search][:attr][:display_name]</tt></td><td>String</td><td></td><td><tt>cn</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:groups][:search][:attr][:member]</tt></td><td>String</td><td></td><td><tt>member</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:groups][:search][:attr][:name]</tt></td><td>String</td><td></td><td><tt>mailRoutingAddress</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:groups][:search][:attr][:owner_dn]</tt></td><td>String</td><td></td><td><tt>owner</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:orgunits][:mapping][:dn]</tt></td><td>String</td><td></td><td><tt>"ou=People,#{node[:gads][:ldap][:basedn]}"</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:orgunits][:mapping][:name]</tt></td><td>String</td><td></td><td><tt>/</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:orgunits][:search][:priority]</tt></td><td>String</td><td></td><td><tt>1</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:orgunits][:search][:basedn]</tt></td><td>String</td><td></td><td><tt>"ou=People,#{node[:gads][:ldap][:basedn]}"</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:orgunits][:search][:scope]</tt></td><td>String</td><td></td><td><tt>SUBTREE</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:orgunits][:search][:filter]</tt></td><td>String</td><td></td><td><tt>objectClass=organizationalUnit</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:orgunits][:search][:attr][:description]</tt></td><td>String</td><td></td><td><tt>ou</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:priority]</tt></td><td>String</td><td></td><td><tt>1</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:basedn]</tt></td><td>String</td><td></td><td><tt>"ou=People,#{node[:gads][:ldap][:basedn]}"</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:suspended]</tt></td><td>String</td><td></td><td><tt>false</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:scope]</tt></td><td>String</td><td></td><td><tt>SUBTREE</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:filter]</tt></td><td>String</td><td></td><td><tt>objectClass=organizationalUnit</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:org_mapping]</tt></td><td>String</td><td></td><td><tt></tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:company_name]</tt></td><td>String</td><td></td><td><tt>0</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:department]</tt></td><td>String</td><td></td><td><tt>department</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:title]</tt></td><td>String</td><td></td><td><tt>title</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:full_name]</tt></td><td>String</td><td></td><td><tt>displayName</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:assistant]</tt></td><td>String</td><td></td><td><tt>secretary</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:manager]</tt></td><td>String</td><td></td><td><tt>manager</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:sync_key]</tt></td><td>String</td><td></td><td><tt>cn</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:street_address]</tt></td><td>String</td><td></td><td><tt>street</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:pobox]</tt></td><td>String</td><td></td><td><tt>postOfficeBox</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:city]</tt></td><td>String</td><td></td><td><tt>l</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:state]</tt></td><td>String</td><td></td><td><tt>st</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:postal_code]</tt></td><td>String</td><td></td><td><tt>postalCode</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:email]</tt></td><td>String</td><td></td><td><tt>mail</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:employee_id]</tt></td><td>String</td><td></td><td><tt>employeeNumber</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:fax]</tt></td><td>String</td><td></td><td><tt>faxsimileTelephoneNumber</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:home_phone]</tt></td><td>String</td><td></td><td><tt>homePhone</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:mobile_phone]</tt></td><td>String</td><td></td><td><tt>mobile</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:work_phone]</tt></td><td>String</td><td></td><td><tt>telephoneNumber</tt></td></tr>
<tr><td><tt>[:gads][:ldap][:users][:search][:attr][:description]</tt></td><td>String</td><td></td><td><tt>description</tt></td></tr>
</table>

Usage
-----
#### gads::default

Just include `gads` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[gads]"
  ]
}
```

Installation will toggle node attributes that control subsequent runs:

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:run_flags][:gads_passwords_encrypted]</tt></td>
    <td>Boolean</td>
    <td>If true, will prevent the configuration template from updating and re-encrypting passwords.</td>
    <td><tt>true</tt>* after the first run
  </tr>
  <tr>
    <td><tt>[:run_flags][:gads_installed]</tt></td>
    <td>Boolean</td>
    <td>If true, will prevent gads from being re-downloaded and re-installed.</td>
    <td><tt>true</tt>* after the first run
  </tr>
</table>

 - If you update your password or configuration, you will need to set the [:run_flags][:gads_passwords_encrypted] value to False in the node attributes overrides for the configuration to be updated.
 - If you want to install a GADS version update, you will need to set the [:run_flags][:gads_installed] value to False to download and install the new version.

License and Authors
-------------------
Author:: Gavin M. Roy (gmr@meetme.com) Copyright:: 2013, MeetMe, Inc

Copyright (c) 2013, MeetMe, Inc. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
Neither the name of the MeetMe, Inc. nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
