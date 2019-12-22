FROM 	debian:buster

# Me
MAINTAINER Peer de Bakker <pde-bakk@student.codam.nl>

# Update and install everything I need
RUN 	apt-get update
RUN 	apt-get install -y nginx
RUN 	apt-get install -y mariadb-server
RUN 	apt-get install -y php7.3-fpm php-common php-mysql php-mbstring
RUN 	apt-get install -y nano

# Copy my srcs folder to a srcs folder in the container
COPY srcs srcs

# Nginx Setup
RUN		mkdir -p /var/www/localhost
RUN 	cp /srcs/nginx-host-conf /etc/nginx/sites-available/localhost
RUN		ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled
RUN		echo "Hello Peer" > /var/www/localhost/index.php

# MySQL setup
RUN		service mysql start; \
		mysql -uroot mysql; \
		mysqladmin password "guest"; \
		echo "CREATE DATABASE wordpress;" | mysql -u root;\
		echo "FLUSH PRIVILEGES;" | mysql -u root

RUN		chown -R www-data:www-data /var/www/localhost/*
RUN		chmod -R 755 /var/www/localhost/*

# Load configs
RUN		tar -xzvf srcs/phpMyAdmin.tar.gz
RUN 	mkdir -p /var/www/localhost/phpmyadmin
RUN 	mkdir -p /var/www/localhost/wordpress
RUN 	mv -v phpMyAdmin-4.9.2-english/* /var/www/localhost/phpmyadmin
RUN 	cp -f srcs/wordpress.tar.gz /var/www/localhost/
RUN 	cd /var/www/localhost/; \
		tar -xzvf /var/www/localhost/wordpress.tar.gz
RUN 	cp -f srcs/config.inc.php /var/www/localhost/phpmyadmin
RUN 	cp -f srcs/wp-config.php /var/www/localhost/wordpress/

# Run
CMD		sh srcs/makeserver.sh
