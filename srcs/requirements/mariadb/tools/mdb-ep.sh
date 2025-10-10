#!/bin/bash

db_name=wordpress
db_user=mysql
db_pwd=pass_42

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

mysqld_safe --datadir=/var/lib/mysql &

until mysqladmin ping -h localhost --silent; do
    echo "Waiting for Mariadb to start..."
    sleep 2
done

echo "MARIDB STARTED !"

echo "CREATE DATABASE IF NOT EXISTS $db_name ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_pwd' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%' ;" >> db1.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mysql < db1.sql

wait
