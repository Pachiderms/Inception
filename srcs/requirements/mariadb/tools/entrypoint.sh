#!/usr/bin/env bash
set -euo pipefail

: "${MYSQL_DATABASE:?}"
: "${MYSQL_USER:?}"
: "${MYSQL_PASSWORD:?}"
: "${MYSQL_ROOT_PASSWORD:?}"

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing database..."
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

  # Démarrage temporaire
  mysqld --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock &
  pid="$!"
  # attendre que le socket soit prêt
  for i in $(seq 1 30); do
    [ -S /run/mysqld/mysqld.sock ] && break
    sleep 1
  done

  # SQL d'init
  cat > /tmp/init.sql <<SQL
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
SQL

  mariadb --protocol=SOCKET --user=root --socket=/run/mysqld/mysqld.sock < /tmp/init.sql
  kill "$pid"
  wait "$pid" || true
fi

# Lancement normal, en avant-plan
exec mysqld --user=mysql --datadir=/var/lib/mysql