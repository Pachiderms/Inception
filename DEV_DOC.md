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

# MARIADB
MYSQL_DATABASE=wordpress
MYSQL_USER=tzizi
MYSQL_PASSWORD_FILE=/run/secrets/db_password
MYSQL_ROOT_PASSWORD_FILE=/run/secrets/db_root_password

# WORDPRESS
WP_TITLE=MarcheWP
WP_ADMIN=superuser42
WP_ADMIN_PASSWORD_FILE=/run/secrets/credentials
WP_ADMIN_EMAIL=email@42.fr

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