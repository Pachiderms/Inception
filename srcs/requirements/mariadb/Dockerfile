FROM debian:13.0

RUN apt-get update -y
RUN apt-get install mariadb-server -y

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/mdb-ep.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mdb-ep.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mdb-ep.sh"]
