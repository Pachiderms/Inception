What's setup ?
    - A docker container that contains NGNIX.
    - A docker container that contains MariaDB.
    - A docker container that contains WordPress + php-fpm.

    - A volume for the WordPress database.
    - A volume for the wordpress website files.
    (volumes are stored on the virtual machine inside /home/login/data)

    - A docker network to connect all containers

Start the project: run make inside the root of the project

Stop the project: run make down inside the root of the project

Acess the website: https://login.42.fr
Acess Admin panel: https://login.42.fr/wp-admin

Check running services: docker ps

.env example:

# DOMAIN
DOMAIN_NAME=tzizi.42.fr

# MARIADB
MYSQL_DATABASE=wordpress
MYSQL_USER=tzizi
MYSQL_PASSWORD_FILE=/run/secrets/db_password
MYSQL_ROOT_PASSWORD_FILE=/run/secrets/db_root_password

# WORDPRESS
WP_TITLE=MarcheWP
WP_ADMIN=superuser42
WP_ADMIN_PASSWORD_FILE=/run/secrets/credentials
WP_ADMIN_EMAIL=admin@localhost
