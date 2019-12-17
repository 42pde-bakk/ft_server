#NGINX SETUP
echo "Hello world"
mkdir -p /var/www/localhost
cp /root/nginx-host-conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

echo "Hello World" > /var/www/localhost/index.php

#Service starter
nginx -g "daemon off;"
# service nginx start
