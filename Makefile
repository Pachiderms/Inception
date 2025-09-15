COMPOSE = docker compose -f srcs/docker-compose.yml
 
all:
	${COMPOSE} up -d --build

down:
	${COMPOSE} down -v

stop: ${COMPOSE} stop

logs:
	${COMPOSE} logs -f

rm: docker system prune -af

ps:
	docker ps -a

re: down all

.PHONY: all down stop logs rm ps re