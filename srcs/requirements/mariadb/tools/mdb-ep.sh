#!/bin/sh

mariadbd-safe --datadir=/var/lib/mysql &

sleep 2;

echo "CREATE DATABASE IF NOT EXISTS $db_name ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_pwd' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%' ;" >> db1.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$db_root_pwd' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mysqladmin -u root -p$db_root_pwd < db1.sql

wait
