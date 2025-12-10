FROM debian:bookworm

RUN apt update -y
RUN apt upgrade -y
RUN apt install mariadb-server tree -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init-db.sh /
RUN chmod +x /init-db.sh
  
EXPOSE 3306

CMD [ "/init-db.sh" ]