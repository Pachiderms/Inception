# !/bin/bash

sleep 15

wp config set --allow-root DB_NAME ${MYSQL_DATABASE}
wp config set --allow-root DB_USER ${MYSQL_USER}
wp config set --allow-root DB_PASSWORD $(cat $MYSQL_PASSWORD_FILE)
wp config set --allow-root DB_HOST mariadb

wp core install --allow-root --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user=${WP_ADMIN_USER} --admin_password=$(cat $WP_ADMIN_PASSWORD_FILE) --admin_email=${WP_ADMIN_EMAIL}

wp user create --allow-root "${WP_USER}" "${WP_EMAIL}" --user_pass=${WP_PASS} --role=author

mkdir -p /run/php

echo "SERVER IS RUNNING......"

/usr/sbin/php-fpm8.2 -F
