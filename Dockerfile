FROM debian:buster

MAINTAINER Peer de Bakker <pde-bakk@student.codam.nl>

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y mariadb-server
RUN apt-get install -y php7.3-fpm php-common php-mysql php-mbstring

RUN mkdir -p /root/mkcert
COPY srcs/nginx-host-conf /root/
COPY srcs/makeserver.sh ./
COPY srcs/localhost.pem /root/mkcert/
COPY srcs/localhost-key.pem /root/mkcert/

CMD bash makeserver.sh