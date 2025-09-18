FROM debian:13.0

RUN apt update
RUN apt-get install mariadb-server -y \
    mariadb-client

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/maria_conf.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/maria_conf.sh
ENTRYPOINT ["/usr/local/bin/maria_conf.sh"]

EXPOSE 3306
CMD ["mysqld"]
