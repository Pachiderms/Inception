## Prerequisites
- A docker container that contains NGNIX.
- A docker container that contains MariaDB.
- A docker container that contains WordPress + php-fpm.
- A volume for the WordPress database.
- A volume for the wordpress website files (volumes are stored on the virtual machine inside /home/login/data).
- A docker network to connect all containers
- A docker compose file
- A .env file located at root with all passwords and users
### .env example
```bash
# DOMAIN
DOMAIN_NAME=login.42.fr

# MYSQL
MYSQL_DATABASE=wordpress
MYSQL_HOST=mariadb
MYSQL_USER=pachiderms
MYSQL_PASSWORD=123
MYSQL_ROOT_PASSWORD=1234

# WORDPRESS
WP_TITLE=WorpressSiteMoi
WP_ADMIN_USER=Pachiderms
WP_USER=tel
WP_EMAIL=pachi@gmail.com
WP_PASS=123
WP_ADMIN_PASSWORD=1234
WP_ADMIN_EMAIL=login@student.42.fr
```

make all: use docker- -f up -d --build
make down: use docker-compose down
make stop: use docker-compose stop.

## Good to known:
    - docker ps to show containers
    - dokcer volume ls to show volumes
    - docker image ls to show images
### Stop running container
```bash
docker stop
```
### Delete all images/conatainers/volumes
```bash
docker system prune -af --volumes 
```
### Delete all volumes and linked containers
```bash
docker rm -vf $(docker ps -aq)
```
### Delete un volume
```bash
docker volume rm VOLUME_NAME
```
### Delete all images
```
docker rmi -f $(docker images -aq)
```
### Build and run a single container
```bash
docker build -t mariadb srcs/requirements/mariadb/ 
docker run -it {container_name}
```
### Execute a container (mariadb) and check user creation
```bash
docker exec -it mariadb mysql -u root -p
SELECT User, Host FROM mysql.user;
```
