#!/bin/sh

sleep 10

cd /var/www/wordpress

# Download WordPress if not present
if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root --path=/var/www/wordpress

    echo "Creating wp-config.php..."
    mv wp-config-sample.php wp-config.php

    sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config.php
    sed -i "s/username_here/$MYSQL_USER/" wp-config.php
    sed -i "s/password_here/$(cat $MYSQL_PASSWORD_FILE)/" wp-config.php
    sed -i "s/localhost/mariadb/" wp-config.php

    echo "Installing WordPress..."
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$(cat $WP_ADMIN_PASSWORD_FILE)" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PWD --alow-root
fi

exec php-fpm8.2 -F

