FROM debian:buster

MAINTAINER Peer de Bakker <pde-bakk@student.codam.nl>

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y mariadb-server
RUN apt-get install -y php7.3-fpm php-common php-mysql php-mbstring
RUN apt-get install -y nano

COPY srcs srcs

# Nginx Setup
RUN mkdir -p /var/www/localhost
RUN cp /srcs/nginx-host-conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled
RUN echo "Hello Peer" > /var/www/localhost/index.php

# MySQL setup
RUN		service mysql start; \
		echo "CREATE DATABASE wordpress;" | mysql -u root; \
		echo "GRANT ALL PRIVILEGES ON wordpress * TO 'root' @ 'localhost'; | mysql -u root
RUN		echo "FLUSH PRIVILEGES;" | mysql -u root;

RUN tar -xzvf srcs/phpMyAdmin.tar.gz

EXPOSE 80
EXPOSE 443

# Load configs
RUN mkdir -p /var/www/localhost/wordpress/phpmyadmin
RUN cp -f srcs/wordpress.tar.gz /var/www/localhost/
RUN tar -xzvf /var/www/localhost/wordpress.tar.gz
RUN cp -f srcs/config.inc.php /var/www/localhost/wordpress/phpmyadmin
RUN cp -f srcs/wp-config.php /var/www/localhost/wordpress/phpmyadmin


#RUN mkdir -p /root/mkcert
#COPY srcs/wordpress.tar.gz /root/
#COPY srcs/phpMyAdmin.tar.gz /root/
#COPY srcs/nginx-host-conf /root/
#COPY srcs/makeserver.sh ./
#COPY srcs/localhost.pem /root/mkcert/
#COPY srcs/localhost-key.pem /root/mkcert/

CMD sh srcs/makeserver.sh
