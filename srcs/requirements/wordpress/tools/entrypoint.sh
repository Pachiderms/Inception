#!/bin/sh
set -e
sleep 10
echo "Waiting for MariaDB..."
until nc -z mariadb 3306; do
    sleep 1
done
echo "MariaDB is up!"

cd /var/www/wordpress

if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress..."
    curl -O https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1
    rm latest.tar.gz
    cp wp-config-sample.php wp-config.php

    wp config set --allow-root DB_NAME $MYSQL_DATABASE
    wp config set --allow-root DB_USER $MYSQL_USER
    wp config set --allow-root DB_PASSWORD $(cat $MYSQL_PASSWORD_FILE)
    wp config set --allow-root DB_HOST $MYSQL_HOST
    

    wp core install --allow-root --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN" --admin_password="$(cat $WP_ADMIN_PASSWORD_FILE)" --admin_email="$WP_ADMIN_EMAIL"

    wp user create --allow-root "$WP_USER" "$WP_EMAIL" --user_pass=$WP_PASS --role=author

    mkdir -p /run/php
    
fi

exec php-fpm8.2 -F