#!/bin/bash
set -e

MYSQL_DATABASE=wordpress
MYSQL_USER=tzizi
MYSQL_PASSWORD=pass_42
MYSQL_ROOT_PASSWORD=root_pass_42

# Lancer mysqld_safe en arrière-plan
mariadbd-safe --datadir=/var/lib/mysql &

# Attendre que MariaDB démarre
until mysqladmin ping >/dev/null 2>&1; do
    echo "En attente de MariaDB..."
    sleep 2
done

# Créer la base et l’utilisateur
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
mysql -u root -e "ALTER USER 'root'@'' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Arrêter le mysqld de fond proprement
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Redémarrer en mode foreground (processus principal du conteneur)
exec mariadbd-safe --datadir=/var/lib/mysql