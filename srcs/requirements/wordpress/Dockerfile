FROM debian:13.0

RUN apt update
RUN apt upgrade -y
RUN apt-get -y install wget \
    php7.3 \
    php.fpm \
    curl \
    bash \
    php-cgi \
    php-mysql \
    php-pdo \
    php-cli \
    mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.7-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.7-fr_FR.tar.gz && rm wordpress-6.7-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress


COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
#RUN mkdir /run/php

COPY ./tools/wp_conf.sh /wp_conf.sh
RUN chmod +x /wp_conf.sh
#ENTRYPOINT [ "/wp_conf.sh" ]

WORKDIR /var/www/html

EXPOSE 9000

#CMD ["/usr/sbin/php-fpm7.3",  "-F"]