What's setup ?
    - A docker container that contains NGNIX.
    - A docker container that contains MariaDB.
    - A docker container that contains WordPress + php-fpm.

    - A volume for the WordPress database.
    - A volume for the wordpress website files.
    (volumes are stored on the virtual machine inside /home/login/data)

    - A docker network to connect all containers

Start the project: 
    run make datadir to create storage on your local machine
    run make inside the root of the project

Stop the project: run make down inside the root of the project

Acess the website: https://login.42.fr
Acess Admin panel: https://login.42.fr/wp-admin

Check running services: docker ps

.env example:

# DOMAIN
DOMAIN_NAME=tzizi.42.fr

# MYSQL
MYSQL_DATABASE=wordpress
MYSQL_HOST=mariadb
MYSQL_USER=tzizi
MYSQL_PASSWORD=123
MYSQL_ROOT_PASSWORD=1234

# WORDPRESS
WP_TITLE=WorpressSiteMoi
WP_ADMIN_USER=Telvin
WP_USER=tel
WP_EMAIL=tel@gmail.com
WP_PASS=123
WP_ADMIN_PASSWORD=1234
WP_ADMIN_EMAIL=tzizi@student.42.fr
