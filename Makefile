COMPOSE = docker compose -f srcs/docker-compose.yml
 
all:
	${COMPOSE} up -d --build

down:
	${COMPOSE} down -v

stop: ${COMPOSE} stop

logs:
	${COMPOSE} logs -f

ps:
	docker ps -a

re: down all
