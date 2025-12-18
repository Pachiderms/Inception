FROM debian:bookworm

RUN apt update -y
RUN apt upgrade -y
RUN apt install mariadb-server net-tools tree -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/init-db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-db.sh

ENTRYPOINT [ "/usr/local/bin/init-db.sh" ]