sudo apt update
sudo apt install -y apache2
sudo service apache2 start
sudo apt install -y mysql-server mysql-client
sudo apt install -y php libapache2-mod-php php-mcrypt php-mysql
mysqladmin -u root password rootpassword
wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/mysqlcommands
sudo cp mysqlcommands /tmp/mysqlcommands
mysql -uroot -prootpassword < /tmp/mysqlcommands
wget https://wordpress.org/latest.zip
sudo apt install -y unzip
cp latest.zip /tmp/latest.zip
sudo unzip /tmp/latest.zip -d /var/www/html
wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/wp-config-sample.php
sudo cp wp-config-sample.php /var/www/html/wordpress/wp-config.php
sudo chmod -R 775 /var/www/html/wordpress
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo service apache2 restart