COMPOSE = docker compose -f srcs/docker-compose.yml
 
all:	
	${COMPOSE} up -d --build

datadir:
	sudo mkdir -p /home/tzizi/data
	sudo mkdir -p /home/tzizi/data/mariadb
	sudo mkdir -p /home/tzizi/data/wordpress

	sudo chown -R $(USER) /home/tzizi/data

clean:
	sudo rm -rf /home/tzizi/data/mariadb/*
	sudo rm -rf /home/tzizi/data/wordpress/*

fclean:
	sudo rm -rf /home/tzizi/data/

down:
	${COMPOSE} down -v

stop: ${COMPOSE} stop

delimages:
	docker rmi -f $(docker images -aq)

re: down all


.PHONY: all datadir clean fclean down stop delimages re
