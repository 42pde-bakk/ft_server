echo "Setting up Nginx now"
#Nginx setup
mkdir -p /var/www/localhost
cp /root/nginx-host-conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

echo "Hello world" > /var/www/localhost/index.php
echo "Setting up SSL now"
#SSL setup
# mkdir -p /root/mkcert
# cp /root/localhost.pem /root/mkcert/
# cp /root/localhost-key.pem /root/mkcert/

echo "starting services now"
#Serice starter
service php7.3-fpm start
nginx -g "daemon off;"
