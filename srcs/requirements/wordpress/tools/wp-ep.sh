#!/bin/bash

# db_name=wordpress
# db_user=mysql_user
# db_pwd=pass_42
# db_root_pwd=root_pass_42

sleep 10

# create directory to use in nginx container later and also to setup the wordpress conf
# mkdir /var/www/
# mkdir /var/www/html

cd /var/www/html


rm -rf *

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

chmod +x wp-cli.phar 

mv wp-cli.phar /usr/local/bin/wp


wp core download --allow-root

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

mv /wp-config.php /var/www/html/wp-config.php


sed -i -r "s/database_name_here/$db_name/1"   /var/www/html/wp-config.php
sed -i -r "s/username_here/$db_user/1"  /var/www/html/wp-config.php
sed -i -r "s/password_here/$db_pwd/1"    /var/www/html/wp-config.php

wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root




wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root


wp theme install astra --activate --allow-root


wp plugin install redis-cache --activate --allow-root

wp plugin update --all --allow-root


 
sed -i 's/listen = \/run\/php\/php8.4-fpm.sock/listen = 9000/g' /etc/php/8.4/fpm/pool.d/www.conf

#mkdir /run/php

wp redis enable --allow-root

/usr/sbin/php-fpm8.4 -F