This project has been created as part of the 42 curriculum by tzizi

Description
    This project aims to discover system administration by using Docker on a virtual machine. I've setup a small infrastructure composed of different services under specific rules with the use of docker compose.

    What's setup ?
        - A docker container that contains NGNIX.
        - A docker container that contains MariaDB.
        - A docker container that contains WordPress + php-fpm.

        - A volume for the WordPress database.
        - A volume for the wordpress website files.
        (volumes are stored on the virtual machine inside /home/login/data)

        - A docker network to connect all containers

Instructions
    run make to make volumes and build+run all containers.
    run make down to stop running containers and remove them (does not remove existing volumes).
    run make stop to stop all containers.


Resources
    https://docs.docker.com/get-started/
    https://github.com/docker/getting-started/issues/381
    https://hub.docker.com/r/mariadb/server/dockerfile
    https://docs.docker.com/reference/dockerfile/
    https://tuto.grademe.fr/inception/
