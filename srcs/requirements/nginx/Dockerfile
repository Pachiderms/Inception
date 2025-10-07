FROM debian:13.0

RUN apt update -y && apt upgrade -y
RUN apt install -y nginx \
        openssl

RUN mkdir -p /etc/nginx/ssl

#generation du certificat ssl et de sa clé
RUN openssl req -x509 -newkey rsa:2048 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=PachiCorp/OU=Pachiderms/CN=${DOMAIN_NAME}/UID=${LOGIN}"

# RUN mkdir -p /var/run/nginx

#copy de notre conf dans nginx
COPY ./conf/nginx.conf /etc/nginx/sites-available/default

RUN chmod +x /var/www/html
RUN chown -R www-data:www-data /var/www/html

#lance nginx au premier plan = le container tourne sans interruption
CMD [ "nginx", "-g", "daemon off;" ]