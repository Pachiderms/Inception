FROM debian:13.0

RUN apt update
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/maria_conf.sh /maria_conf.sh
RUN chmod +x /maria_conf.sh

EXPOSE 3306

ENTRYPOINT ["/maria_conf.sh"]