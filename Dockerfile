FROM debian:buster

MAINTAINER pde-bakk

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y mariadb-server
RUN apt-get install -y php-fpm
CMD ["echo", "Image created"]
CMD ["nginx", "-g", "daemon off;"]

