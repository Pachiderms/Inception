#!/bin/sh
set -e

if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    mariadbd --user=mysql --skip-networking &
    pid=$!

    until mysqladmin ping --silent; do
        sleep 1
    done

    mysql <<EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$(cat $MYSQL_PASSWORD_FILE)';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
CREATE USER 'root'@'%' IDENTIFIED BY '$(cat $MYSQL_ROOT_PASSWORD_FILE)';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat $MYSQL_ROOT_PASSWORD_FILE)';
FLUSH PRIVILEGES;
EOF

    kill $pid
fi

exec mariadbd --user=mysql
