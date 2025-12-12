#!/bin/sh
set -e

DB_DIR="/var/lib/mysql"

mkdir -p /run/mysqld "$DB_DIR"
chown -R mysql:mysql /run/mysqld "$DB_DIR"

mysqld_safe --user=mysql --datadir="$DB_DIR" &

sleep 5

ps aux | grep mysqld 
netstat -lnp | grep mysqld

mysql -uroot << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

echo "MariaDB CONFIG DONE."

exec mysqld_safe --user=mysql --datadir="$DB_DIR"
