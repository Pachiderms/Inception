FROM debian:12-slim

RUN apt-get update && apt-get install -y \
    php-fpm php-mysql php-json php-curl php-dom php-mbstring \
    mariadb-client curl tar wget netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/wordpress

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
