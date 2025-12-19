FROM debian:bookworm

RUN apt update -y && apt upgrade -y

RUN apt install -y wget php mariadb-client \
    php-fpm php-mysql php-redis \
    curl tar netcat-openbsd sendmail

WORKDIR /var/www

RUN	wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz
RUN	tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz


COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/wordpress

RUN mv wp-config-sample.php wp-config.php

COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN ln -sf /bin/true /usr/sbin/sendmail

EXPOSE 3309

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
