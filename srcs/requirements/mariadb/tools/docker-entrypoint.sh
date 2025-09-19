#!/bin/sh

MYSQL_DB=wordpress
MYSQL_USER=tzizi
MYSQL_PASS=pass_42
MYSQL_ROOT_PASS=root_pass_42

# Lancer mysqld_safe en arrière-plan
DATADIR="/var/lib/mysql"

# Si la base n'est pas initialisée
if [ ! -d "$DATADIR/mysql" ]; then
    echo "==> Initialisation de MariaDB..."
    mariadb-install-db --user=mysql --datadir="$DATADIR" > /dev/null

    echo "==> Démarrage temporaire de MariaDB..."
    mysqld_safe --skip-networking --datadir="$DATADIR" &
    pid="$!"

    # Attendre que MariaDB soit prêt
    for i in {30..0}; do
        if mariadb -uroot --protocol=socket -e "SELECT 1" &>/dev/null; then
            break
        fi
        echo "   Attente de MariaDB ($i)..."
        sleep 1
    done
    if [ "$i" = 0 ]; then
        echo "Erreur: MariaDB ne démarre pas."
        exit 1
    fi

    echo "==> Configuration initiale de MariaDB..."

    # Modifier le mot de passe root
    mariadb -uroot --protocol=socket <<-EOSQL
        ALTER USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASS}';
        FLUSH PRIVILEGES;
EOSQL

    # Créer base et utilisateur
    mariadb -uroot -p"${MYSQL_ROOT_PASS}" --protocol=socket <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL

    # Arrêt temporaire
    if ! kill -s TERM "$pid" || ! wait "$pid"; then
        echo "Erreur: impossible d'arrêter MariaDB."
        exit 1
    fi

    echo "==> Initialisation terminée."
fi

echo "==> Lancement de MariaDB..."
exec "$@"