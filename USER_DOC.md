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