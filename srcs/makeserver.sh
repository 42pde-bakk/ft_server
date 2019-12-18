echo "Setting up Nginx now"
# Nginx setup
# cd
# mkdir -p /var/www/localhost
# cp /root/nginx-host-conf /etc/nginx/sites-available/localhost
# ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

# echo "Hello world" > /var/www/localhost/index.php
# echo "Setting up SSL now"
# SSL setup
# mkdir -p /root/mkcert
# cp /root/localhost.pem /root/mkcert/
# cp /root/localhost-key.pem /root/mkcert/

# Mysql setup
#service mysql start
#echo "CREATE DATABASE wordpress;" | mysql -u root

# Wordpress installation
#cd
#mv wordpress.tar.gz /var/www/localhost/
#cd /var/www/localhost
#tar -xf wordpress.tar.gz
#rm wordpress.tar.gz

# PHP-Myadmin installation
#cd
#mkdir /var/www/localhost/phpmyadmin
#tar -xzf phpMyAdmin.tar.gz

echo "starting services now"
#Serice starter
service php7.3-fpm start
nginx -g "daemon off;"
