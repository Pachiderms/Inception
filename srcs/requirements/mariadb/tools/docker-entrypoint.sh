#!/bin/sh

set -euo pipefail

MYSQL_DB=wordpress
MYSQL_USER=tzizi
MYSQL_PASS=pass_42
MYSQL_ROOT_PASS=root_pass_42

# Lancer mysqld_safe en arrière-plan
mariadbd-safe --datadir=/var/lib/mysql start

if [ -d "/var/lib/mysql/${MYSQL_DB}" ]
then
    echo "Databe: ${MYSQL_DB} already exists"
else

mariadb-secure-installation << _EOF_

Y
${MYSQL_ROOT_PASS}
${MYSQL_ROOT_PASS}
Y
n
Y
Y
_EOF_
# Créer la base et l’utilisateur
mysql -uroot "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASS}';"
mysql -uroot "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"
#mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}';"
mysql -uroot "GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO '${MYSQL_USER}'@'%'; IDENTIFIED BY '${MYSQL_PASS}'"
mysql -uroot "FLUSH PRIVILEGES;"

# Arrêter le mysqld de fond proprement
mysqladmin -uroot -p"${MYSQL_ROOT_PASS}" shutdown

fi

mariadbd-safe --datadir=/var/lib/mysql stop

exec "$@"