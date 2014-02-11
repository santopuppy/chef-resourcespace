include_recipe 'php'
package "php5-gd"
package "php5-mysql"

include_recipe 'apache2'
include_recipe 'apache2::mod_php5'

include_recipe 'imagemagick'
package 'ghostscript'
package 'antiword'
package 'xpdf'
package 'ffmpeg'
package 'postfix'
package 'libimage-exiftool-perl'
package 'cron'
package 'wget'

include_recipe 'subversion'

include_recipe 'mysql::server'
include_recipe 'database::mysql'

mysql_connection_info = { host:      node['resourcespace']['mysql_server'],
                          username:  'root',
                          password:  node['mysql']['server_root_password'] }


subversion "ResourceSpace" do
  repository "http://svn.montala.net/svn/resourcespace"
  revision node['resourcespace']['revision']
  destination "/var/www/resourcespace"
  group "root"
  user "root"
  action :checkout
end

directory "/var/www/resourcespace" do
  group "www-data"
  user "www-data"
end

directory "/var/www/resourcespace/include" do
  mode '755'
end

template "/var/www/resourcespace/include/config.php" do
  source "config.php.erb"
end

template "/etc/php5/apache2/php.ini" do
  source "php.ini.erb"
end

directory "/var/www/resourcespace/filestore" do
  mode '777'
  not_if { File.exist?("/var/www/resourcespace/filestore") }
end

web_app "resourcespace" do
  server_name "resourcespace"
  docroot "/var/www/resourcespace"
  log_dir node['apache']['log_dir']
end

mysql_database node['resourcespace']['config']['mysql']['mysql_db'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['resourcespace']['config']['mysql']['mysql_username'] do
  connection    mysql_connection_info
  password      node['resourcespace']['config']['mysql']['mysql_password']
  database_name node['resourcespace']['config']['mysql']['mysql_db']
  host          node['resourcespace']['config']['mysql']['mysql_server']
  privileges    [:all]
  action        :grant
end

service "apache2" do
  supports :restart => true, :reload => true
  action :nothing
  subscribes :reload, "web_app[resourcespace]", :delayed
  subscribes :reload, "template[/etc/php5/apache2/php.ini]", :delayed
end