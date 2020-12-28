execute "update" do
  command "apt update -y"
end
packages =['apache2','mysql-server', 'mysql-client', 'php', 'libapache2-mod-php', 'php-mcrypt', 'php-mysql']
  packages.each do |package|
  apt_package package do
    action :install
  end 
end
service "apache2" do
  action :start
end
execute "password" do
  command "mysqladmin -u root password rootpassword"
end
remote_file "mysqlcommand" do
    source 'https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/mysqlcommands'
    path "/tmp/mysqlcommands"
end
execute "rootpassword" do
  command "mysql -uroot -prootpassword < /tmp/mysqlcommands"
end
remote_file "wordpress" do
    source 'https://wordpress.or/var/www/html/wordpress
end
execute "unzip" do
 command "unzip /tmp/latest.zip -d /var/www/html"
end
remote_file "php" do
    source 'https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/wp-config-sample.php'
end
execute "copy" do
 command "cp wp-config-sample.php /var/www/html/wordpress/wp-config.php"
end
file '/var/www/html/wordpress' do
  mode '0755'
  owner 'www-data'
  group 'www-data'
end
service "apache2" do
  action :restart
end
