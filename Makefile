all:
	docker-compose -f srcs/docker-compose.yml up --build -docker

down:
	docker-compose -f srcs/docker-compose.yml down

re: down all