#!/bin/bash
set -e

DATADIR="/var/lib/mysql"

mkdir -p /run/mysqld "${DATADIR}"
chown -R mysql /run/mysqld "${DATADIR}"

if [ ! -f /var/lib/mysql/"${MYSQL_DATABASE}" ]; then
    echo ">> INIT DE MARIADB"
    mariadb-install-db

    cat > /tmp/init.sql <<EOF
DELETE FROM mysql.user WHERE User='';

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF
    echo "MARIADB INIT OK!"
fi

exec mariadbd --init-file=/tmp/init.sql