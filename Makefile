COMPOSE = docker compose -f srcs/docker-compose.yml
DOMAIN_NAME := $(shell sed -n 's/^DOMAIN_NAME=//p' srcs/.env | tr -d '\r')

all:	
	${COMPOSE} up -d --build ; @grep -q "\b$(DOMAIN_NAME)\b" /etc/hosts || echo "127.0.0.1 $(DOMAIN_NAME)" 

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

delimages:
	docker rmi -f $$(docker images -aq)

re: down all

.PHONY: all datadir localhost unhost clean fclean down delimages re
