COMPOSE = docker compose -f srcs/docker-compose.yml
 
all:
	${COMPOSE} up -d --build

down:
	${COMPOSE} down

logs:
	${COMPOSE} logs -f

re: down all

ps:
	docker ps -a