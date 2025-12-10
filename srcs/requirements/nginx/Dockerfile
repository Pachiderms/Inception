FROM debian:bookworm

RUN apt update -y
RUN apt upgrade -y
RUN apt install nginx -y
RUN apt install openssl -y
RUN apt install nano -y
RUN apt clean

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=1337/CN=tzizi.42.fr/UID=tzizi"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/wordpress
RUN chmod 775 /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

EXPOSE 443

CMD	["nginx", "-g", "daemon off;"]