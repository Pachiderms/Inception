#!/bin/sh
set -e

echo "Waiting for MariaDB..."
until nc -z mariadb 3306; do
    sleep 1
done
echo "MariaDB is up!"

cd /var/www/wordpress

if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root --path=/var/www/wordpress

    echo "Creating wp-config.php..."
    wp config create \
        --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$(cat $MYSQL_PASSWORD_FILE)" \
        --dbhost="mariadb"

    echo "Installing WordPress..."
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$(cat $WP_ADMIN_PASSWORD_FILE)" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    wp user create $WP_USER $WP_EMAIL \
        --role=author \
        --user_pass=$WP_PWD \
        --allow-root
fi

exec php-fpm8.2 -F