FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY tools /tools
RUN chmod +x /tools/init.sh

EXPOSE 3306

CMD["mysqld_safe"]