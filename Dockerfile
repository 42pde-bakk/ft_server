FROM debian:buster

#Updating and installing nginx
RUN apt-get update && apt-get install -y nginx

RUN apt-get install -y mariadb-server
COPY nginx-host-conf /root/
COPY makeserver.sh makeserver.sh
CMD bash makeserver.sh
