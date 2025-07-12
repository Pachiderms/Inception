FROM debian:bullseye

RUN apt-get update && apt-get install -y php-fpm phm-mysql wget unzip curl

WORKDIR /var/www/html

COPY tools /tools
RUN chmod +x /tools/setup.sh

EXPOSE 9000

CMD["php-fpm.4", "-F"]