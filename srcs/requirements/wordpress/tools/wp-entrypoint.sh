sleep 10;

wp config create --allow-root \
            --dbname=$MYSQL_DATABASE \
            --dbuser=$MYSQL_USER \
            --dbpass=$MYSQL_PASSWORD \
            --dbhost=mariadb:3306 --path='/var/www/html/wordpress'

wp core install
wp user create