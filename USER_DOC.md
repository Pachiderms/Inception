## Overview
 - A docker container that contains NGNIX.
 - A docker container that contains MariaDB.
 - A docker container that contains WordPress + php-fpm.
 - A volume for the WordPress database.
 - A volume for the wordpress website files.
 (volumes are stored on the virtual machine inside /home/login/data)
 - A docker network to connect all containers

## Run Project

```bash
make datadir # to create storage on your local machine 
make # at the root of the project
```
Stop containers
```bash
make down # at the root of the project
```

## Services
Access the website: https://login.42.fr
Access Admin panel: https://login.42.fr/wp-admin

Check running services: ```docker ps```


## .env example:

```
# DOMAIN
DOMAIN_NAME=login.42.fr

# MYSQL
MYSQL_DATABASE=wordpress
MYSQL_HOST=mariadb
MYSQL_USER=pachi
MYSQL_PASSWORD=123
MYSQL_ROOT_PASSWORD=1234

# WORDPRESS
WP_TITLE=WorpressSiteMoi
WP_ADMIN_USER=Telvin
WP_USER=tel
WP_EMAIL=tel@gmail.com
WP_PASS=123
WP_ADMIN_PASSWORD=1234
WP_ADMIN_EMAIL=login@student.42.fr
```
