#!/bin/sh

MYSQL_DATABASE=wordpress
MYSQL_USER=tzizi
MYSQL_PASSWORD=pass_42
MYSQL_ROOT_PASSWORD=root_pass_42

mariadbd-safe --datadir=/var/lib/mysql &

mysql -e "CREATE DATABASE IF NOT EXISTS \ '${MYSQL_DATABASE}\';"
mysql -e "CREATE USER IF NOT EXISTS \'${MYSQL_USER}\'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON  \'${MYSQL_DATABASE}\'.* TO \ '${MYSQL_USER}\'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
#Modification sur le root user mdp
mysql -e "ALTER USER 'root'@localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
#Refresh mysql pour appliquer les changements
mysql -e "FLUSH PRIVILEGES;"
#Redemarrer mysql
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
exec mariadbd-safe
