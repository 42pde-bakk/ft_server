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
		mysql -uroot mysql; \
		mysqladmin password "guest"; \
		echo "CREATE DATABASE wordpress;" | mysql --user=root;\
		echo "FLUSH PRIVILEGES;" | mysql --user=root

RUN		chown -R www-data:www-data /var/www/localhost/*
RUN		chmod -R 755 /var/www/localhost/*

EXPOSE 80
EXPOSE 443

# Load configs
RUN tar -xzvf srcs/phpMyAdmin.tar.gz
RUN mkdir -p /var/www/localhost/phpmyadmin
RUN mkdir -p /var/www/localhost/wordpress
RUN mv -v phpMyAdmin-4.9.2-english/* /var/www/localhost/phpmyadmin
RUN cp -f srcs/wordpress.tar.gz /var/www/localhost/
RUN cd /var/www/localhost/; \
	tar -xzvf /var/www/localhost/wordpress.tar.gz
RUN cp -f srcs/config.inc.php /var/www/localhost/phpmyadmin
RUN cp -f srcs/wp-config.php /var/www/localhost/wordpress/

CMD sh srcs/makeserver.sh


# mysqladmin password "guest"
# echo "DELETE FROM mysql.user WHERE User='';" | mysql --user=root
# echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" | mysql --user=root

# echo "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';" | mysql --user=root