FROM debian:bookworm

RUN apt update -y && apt upgrade -y

RUN apt install wget php8.2 mariadb-client php8.2-fpm php8.2-mysql curl tar netcat-openbsd -y

WORKDIR /var/www

RUN	wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz

RUN	tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

RUN	chown -R root:root /var/www/wordpress

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/wordpress

RUN mv wp-config-sample.php wp-config.php

COPY tools/entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 9000

CMD [ "/bin/bash", "/entrypoint.sh" ]
