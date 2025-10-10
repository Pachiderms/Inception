FROM debian:13.0

RUN apt-get update -y
RUN apt-get install mariadb-server -y

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/mdb-ep.sh /
RUN chmod +x /mdb-ep.sh

CMD ["/mdb-ep.sh"]
