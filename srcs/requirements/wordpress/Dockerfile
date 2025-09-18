FROM debian:13.0

RUN apt update
RUN apt upgrade -y
RUN apt-get -y install wget \
    php7.3 \
    php-fpm \
    php-mysql
#    curl \
#    bash \
#    php-cgi \
#    php-pdo \
#    php-gd php-cli \
#    php-mbstring \
#    && rm -rf /var/lib/apt/lists/*

RUN wget https://fr.wordpress.org/wordpress-6.7-fr_FR.tar.gz -P /var/www/
RUN cd /var/www/ && tar -xzf wordpress-6.7-fr_FR.tar.gz && rm wordpress-6.7-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress

#dl de la cli (interface style bas h aui traite des commandes pour un programme informatiuqe) et gestion de ses droits
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

#RUN mkdir /var/run/php

COPY ./tools/wp-entrypoint.sh /var/www/
RUN chmod +x /var/www/wp-entrypoint.sh
ENTRYPOINT [ "/var/www/wp-entrypoint.sh" ]

EXPOSE 9000
CMD ["/usr/sbin/php-fpm7.3",  "-F"]