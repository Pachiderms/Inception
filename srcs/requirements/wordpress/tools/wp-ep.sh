#!/bin/bash

db_name=wordpress
db_user=mysql
db_pwd=pass_42
sleep 10

mkdir -p /var/www/html
cd /var/www/html

# install wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# download wordpress
wp core download --allow-root

# configure wp-config
mv wp-config-sample.php wp-config.php

sed -i "s/database_name_here/$db_name/" wp-config.php
sed -i "s/username_here/$db_user/" wp-config.php
sed -i "s/password_here/$db_pwd/" wp-config.php
sed -i "s/localhost/mariadb/" wp-config.php

# install wordpress
wp core install --allow-root \
  --url="https://localhost:8443" \
  --title="My Wordpress Site" \
  --admin_user="pachiderms" \
  --admin_password="thepwd" \
  --admin_email="mail@example.com"

wp user create user user@example.com --role=author --user_pass=userpass --allow-root

# plugins
wp theme install astra --activate --allow-root
wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root

mkdir -p /run/php
php-fpm8.4 -F
