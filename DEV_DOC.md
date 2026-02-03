What's needed ?
    - A docker container that contains NGNIX.
    - A docker container that contains MariaDB.
    - A docker container that contains WordPress + php-fpm.

    - A volume for the WordPress database.
    - A volume for the wordpress website files.
    (volumes are stored on the virtual machine inside /home/login/data)

    - A docker network to connect all containers
    - A docker compose file
    - A .env file located at root with all passwords and users
example:
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
WP_ADMIN_USER=moiTelvin
WP_USER=tel
WP_EMAIL=tel@gmail.com
WP_PASS=123
WP_ADMIN_PASSWORD=1234
WP_ADMIN_EMAIL=tzizi@student.42.fr


make all: use docker- -f up -d --build
make down: use docker-compose down
make stop: use docker-compose stop.

Good to known:
    - docker ps to show containers
    - dokcer volume ls to show volumes
    - docker image ls to show images

    - docker stop DOCKER_ID -> kill running container rm to - remove or rm -f to force remove
    - docker system prune -af --volumes -> clean les images/conatainers/volumes
    - delete all volumes and linked containers
    - docker rm -vf $(docker ps -aq)

    - delete un volume
    - docker volume rm $(docker volume ls -q | grep mariadb_data)
    - delete all images
    - docker rmi -f $(docker images -aq)
    - docker build -t mariadb srcs/requirements/mariadb/ 
    - docker run -it {container_name}

        check les creations mariadb
    - docker exec -it mariadb mysql -u root -p
    - SELECT User, Host FROM mysql.user;