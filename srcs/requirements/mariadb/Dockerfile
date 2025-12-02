FROM debian:12-slim

RUN apt update && apt install -y mariadb-server mariadb-client && apt clean

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

COPY conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init-db.sh /init-db.sh

RUN chmod +x /init-db.sh

EXPOSE 3306

ENTRYPOINT ["/init-db.sh"]
