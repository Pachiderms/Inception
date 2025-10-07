FROM debian:13.0

RUN apt-get update -y && apt-get upgrade -y
RUN apt update -y && apt upgrade -y
RUN apt -y install php-fpm \
    php-mysql \
    curl

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY ./tools/wp-ep.sh /var/www/
RUN chmod +x /var/www/wp-ep.sh
ENTRYPOINT [ "/var/www/wp-ep.sh" ]

EXPOSE 9000
