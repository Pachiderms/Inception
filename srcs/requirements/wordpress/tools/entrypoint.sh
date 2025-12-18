#!/bin/sh
set -e

chown -R www-data:www-data /run/php /var/www/wordpress

until mariadb -h mariadb -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1;"; do
    echo "Waiting for mariadb setup"
    sleep 1
done

wp config set --allow-root DB_NAME ${MYSQL_DATABASE}
wp config set --allow-root DB_USER ${MYSQL_USER}
wp config set --allow-root DB_PASSWORD ${MYSQL_PASSWORD}
wp config set --allow-root DB_HOST mariadb:3306

wp core install --allow-root --url="https://$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL"

wp user create --allow-root "$WP_USER" "$WP_EMAIL" --user_pass="$WP_PASS"

echo "SERVER RUNNING"

exec /usr/sbin/php-fpm8.2 -F
