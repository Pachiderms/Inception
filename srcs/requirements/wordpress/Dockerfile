FROM alpine:3.19

# PHP-FPM + extensions nécessaires WordPress
RUN apk add --no-cache php82 php82-fpm php82-mysqli php82-json php82-opcache php82-curl \
    php82-dom php82-exif php82-fileinfo php82-mbstring php82-openssl php82-pecl-redis \
    php82-session php82-zip curl bash openssl

# Préparer php-fpm en mode "foreground"
RUN sed -i 's|^;*daemonize = yes|daemonize = no|' /etc/php82/php-fpm.conf \
 && sed -i 's|^;*listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|' /etc/php82/php-fpm.d/www.conf

# Installer WordPress au démarrage si absent
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html
EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]