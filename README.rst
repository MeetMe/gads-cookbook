Google Apps Directory Sync Cookbook
===================================
Installs and configures Google Apps Directory Sync in a Linux environment

Requirements
------------
The `gads::default` cookbook will install the one dependency gem, greenletters which is used to automate interaction with the installation script and the password encryption script.

**cookbooks**

- `java` - Java is required to run Google App Directory Sync. The gads::default recipe installs using the default behavior. Include java in your runlist prior to gads if you want to change the install behavior.

Attributes
----------

**gads::default**

+------------------------------+--------+-------------+---------------------------------------------------+
| Key                          | Type   | Description | Default                                           |
+==============================+========+=============+===================================================+
|``[:gads][:download_url]``    | String |             |``http://dl.google.com/dirsync/dirsync-linux64.sh``|
|``[:gads][:create_symlinks]`` | Boolean|             |``true``                                           |
|``[:gads][:install_path]``    | String |             |``/opt/GoogleAppsDirSync``                         |
|``[:gads][:synlinks_path]``   | String |             |``/usr/local/bin``                                 |
|``[:gads][:config_path]``     | String |             |``/usr/local/etc/gads.xml``                        |
|``[:gads][:config_version]``  | String |             |``3.1.6``                                          |
|``[:gads][:features]``        | Array  |             |* ``CACHE_PASSWORD_TIMESTAMPS``                    |
|                              |        |             |*  ``ALIAS_SYNCHRONIZATION``                       |
|                              |        |             |*  ``USER_PROFILES``                               |
|                              |        |             |*  ``SKIP_CALENDAR_RESOURCES``                     |
|                              |        |             |*  ``GROUP_DESCRIPTION``                           |
|                              |        |             |*  ``GROUP_OWNER``                                 |
|                              |        |             |*  ``SUSPEND_USERS``                               |
|                              |        |             |*  ``NON_ADDRESS_PRIMARY_KEY``                     |
|                              |        |             |*  ``GOOGLE_ORGUNITS``                             |
|                              |        |             |*  ``SHA1_PASSWORD``                               |
|                              |        |             |*  ``MULTIDOMAIN``                                 |
|                              |        |             |*  ``SKIP_SUSPENDING_ADMINS``                      |
|                              |        |             |*  ``FAMILY_NAME``                                 |
|                              |        |             |*  ``GIVEN_NAME``                                  |
|                              |        |             |*  ``SHARED_CONTACTS``                             |
|                              |        |             |*  ``GROUPS``                                      |
|``[:gads][:google][:exclude]``| Array  |             || ``{:match => 'USER_NAME',``                      |
|                              |        |             || ``:type =>  'EXACT',``                           |
|                              |        |             || ``:filter => 'foo@bar.com'},``                   |
+------------------------------+--------+-------------+---------------------------------------------------+

Usage
-----
**gads::default**

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
    <td><tt>[:run_flags][:gads_passwords_encrypted]`|
    <td>Boolean</td>
    <td>If true, will prevent the configuration template from updating and re-encrypting passwords.</td>
    <td><tt>true</tt>* after the first run
  </tr>
  <tr>
    <td><tt>[:run_flags][:gads_installed]`|
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
