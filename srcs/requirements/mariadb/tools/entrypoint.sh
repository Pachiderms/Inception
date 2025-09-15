#!/bin/sh
set -e

# Initialiser la DB si vide
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

    mysqld_safe --skip-networking &
    pid="$!"

    # Attendre que mariadb démarre
    for i in {30..0}; do
        if mariadb -uroot -e "SELECT 1" > /dev/null 2>&1; then
            break
        fi
        echo 'MariaDB init...'
        sleep 1
    done

    # Exécuter ton init.sql
    mariadb -uroot < /docker-entrypoint-initdb.d/init.sql

    # Stopper mysqld
    kill -s TERM "$pid"
    wait "$pid"
fi

echo "MariaDB started!"
exec mysqld_safe
