COMPOSE = docker compose -f srcs/docker-compose.yml
DOMAIN_NAME := $(shell sed -n 's/^DOMAIN_NAME=//p' srcs/.env | tr -d '\r')

all:	
	${COMPOSE} up -d --build

datadir:
	sudo mkdir -p /home/tzizi/data
	sudo mkdir -p /home/tzizi/data/mariadb
	sudo mkdir -p /home/tzizi/data/wordpress

	sudo chown -R $(USER) /home/tzizi/data

localhost:
	hosts: ; @grep -q "\b$(DOMAIN_NAME)\b" /etc/hosts || echo "127.0.0.1 $(DOMAIN_NAME)" | sudo tee -a /etc/hosts

unhost: ; @sudo sed -i.bak "/\b$(DOMAIN_NAME)\b/d" /etc/hosts

clean:
	sudo rm -rf /home/tzizi/data/mariadb/*
	sudo rm -rf /home/tzizi/data/wordpress/*

fclean:
	sudo rm -rf /home/tzizi/data/

down:
	${COMPOSE} down -v

stop: ${COMPOSE} stop

delimages:
	docker rmi -f $$(docker images -aq)

re: down all


.PHONY: all datadir localhost unhost clean fclean down stop delimages re
