# This project has been created as part of the 42 curriculum by tzizi

## Description
This project aims to discover system administration by using Docker on a virtual machine. I've setup a small infrastructure composed of different services under specific rules with the use of docker compose.

What's setup ?
- A docker container that contains NGNIX.
- A docker container that contains MariaDB.
- A docker container that contains WordPress + php-fpm.
- A volume for the WordPress database.
- A volume for the wordpress website files (volumes are stored on the virtual machine inside /home/login/data)
- A docker network to connect all containers

## Instructions
### Create local storage on machine
``` bash
make datadir
```
### Build volumes and run all containers
``` bash
make
```
### Stop all running containers does not remove them
``` bash
make stop
```
## Resources
https://docs.docker.com/get-started/
https://github.com/docker/getting-started/issues/381
https://hub.docker.com/r/mariadb/server/dockerfile
https://docs.docker.com/reference/dockerfile/
https://tuto.grademe.fr/inception/
