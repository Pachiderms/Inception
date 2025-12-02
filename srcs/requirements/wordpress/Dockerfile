FROM debian:12-slim

RUN apt update && apt install -y php-fpm php-mysql php-curl curl && apt clean

COPY conf/php-fpm.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
