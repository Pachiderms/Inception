#!/bin/sh
set -e

# Dossier de la base MariaDB
DB_DIR="/var/lib/mysql"

# Si le dossier est vide → initialisation
if [ ! -d "$DB_DIR/mysql" ]; then
    echo "Initialisation de MariaDB..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=$DB_DIR

    # Démarrage temporaire pour créer la base et l'utilisateur
    mysqld --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$(cat $MYSQL_PASSWORD_FILE)';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat $MYSQL_ROOT_PASSWORD_FILE)';
FLUSH PRIVILEGES;
EOF
    echo "MariaDB initialisée."
else
    echo "Base déjà existante, skip initialisation."
fi

echo "Lancement de MariaDB..."
exec mysqld --user=mysql