COMPOSE = docker compose -f srcs/docker-compose.yml
 
all:
	${COMPOSE} up -d --build

down:
	${COMPOSE} down -v

stop: ${COMPOSE} stop

re: down all


.PHONY: all down stop re
