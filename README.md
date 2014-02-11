# chef-resourcespace-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['resourcespace']['config']['mysql']</tt></td>
    <td>Hash</td>
    <td>Hash that contains the database connection configuration. Without this the recipe won't work</td>
    <td>n/a (required)</td>
  </tr>
  <tr>
    <td><tt>['resourcespace']['config']['baseurl']</tt></td>
    <td>String</td>
    <td>The base url of the resourcespace installation</td>
    <td>n/a (required)</td>
  </tr>
  <tr>
    <td><tt>['resourcespace']['config']['email']</tt></td>
    <td>Hash</td>
    <td>Hash that contains the email configs for the resourcespace configuration</td>
    <td>n/a (required)</td>
  </tr>
  <tr>
    <td><tt>['resourcespace']['config']['spider_password']</tt></td>
    <td>String</td>
    <td>Make sure to create a secure one!</td>
    <td>n/a (required)</td>
  </tr>
  <tr>
    <td><tt>['resourcespace']['config']['scramble_key']</tt></td>
    <td>String</td>
    <td>Make sure to create a secure one!</td>
    <td>n/a (required)</td>
  </tr>
  <tr>
    <td><tt>['resourcespace']['config']['api_scramble_key']</tt></td>
    <td>String</td>
    <td>Make sure to create a secure one!</td>
    <td>n/a (required)</td>
  </tr>
</table>

## Usage

### chef-resourcespace::default

Include `chef-resourcespace` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[resourcespace]"
  ]
}
```

Make sure to add the required json attributes. An example if you are using Vagrant:

```ruby
config.vm.provision :chef_solo do |chef|
  chef.run_list = [
      "recipe[resourcespace]"
  ]

  chef.json = {
    mysql: {
      server_debian_password: 'securedebpass',
      server_root_password: 'securerootpass',
      server_repl_password: 'securereplpass'
    },
    resourcespace: {
      config: {
        mysql: {
          mysql_server: 'localhost',
          mysql_username: 'resourcespace',
          mysql_password: 'super_secret',
          mysql_db: 'resourcespace'
        },
        baseurl: 'http://localhost:10080',
        email: {
          email_from: 'resourcespace@example.com',
          email_notify: 'resourcespace@example.com'
        },
        spider_password: 'mytuba5aSEGA',
        scramble_key: '5YvAhAgYdyny',
        api_scramble_key: 'nEQYXATUmuzU'
      }
    }
  }
end
```


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Lester Celestial (<lesterc@sourcepad.com>)

```text
Copyright 2009-2014 SourcePad, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
