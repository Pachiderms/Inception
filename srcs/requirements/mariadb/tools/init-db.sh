#!/bin/sh
set -e

if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    mariadbd --user=mysql --skip-networking &
    pid=$!

    until mysqladmin ping --silent; do
        sleep 1
    done

mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"

mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$(cat $MYSQL_PASSWORD_FILE)';"

mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat $MYSQL_ROOT_PASSWORD_FILE)';"

mysql -u root -p"$(cat $MYSQL_ROOT_PASSWORD_FILE)" -e "FLUSH PRIVILEGES;"


    kill $pid

fi

exec mariadbd --user=mysql
