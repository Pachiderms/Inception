service mysql start;

mysql -e "CREATE DATABASE IF NOT EXISTS \ '${MYSQL_DATABASE}\';"
mysql -e "CREATE USER IF NOT EXISTS \'${MYSQL_USER}\'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON  \'${MYSQL_DATABASE}\'.* TO \ '${MYSQL_USER}\'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
#Modification sur le root user mdp
mysql -e "ALTER USER 'root'@localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
#Refresh mysql pour appliquer les changements
mysql -e "FLUSH PRIVILEGES;"
#Redemarrer mysql
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
exec mysqld_safe
