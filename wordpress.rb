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
  execute "mysql import" do
	command "mysql -uroot -prootpassword < /tmp/mysqlcommands && touch /var/mysqlimportcomplete"
	not_if {File.exists?("/var/mysqlimportcomplete")}
 end
end
remote_file "wordpress" do
    source 'https://wordpress.org/latest.zip'
	path "/tmp/latest.zip
end
execute "unzip" do
 command "unzip /tmp/latest.zip -d /var/www/html"
end
remote_file "php" do
    source 'https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/wp-config-sample.php'
	path "/var/www/html/wordpress/wp-config.php"
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
