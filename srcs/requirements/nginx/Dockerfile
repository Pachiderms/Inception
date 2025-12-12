FROM debian:bookworm

RUN apt update -y
RUN apt upgrade -y
RUN apt install nginx -y
RUN apt install openssl -y

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=1337/CN=tzizi.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD	["nginx", "-g", "daemon off;"]