FROM debian:13.0

RUN apt update
RUN apt-get install mariadb-server -y \
    mariadb-client \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

EXPOSE 3306

#COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/maria_conf.sh /usr/local/bin/maria_conf.sh
RUN chmod +x /usr/local/bin/maria_conf.sh

ENTRYPOINT ["/usr/local/bin/maria_conf.sh"]

CMD ["mysqld", "--bind-adress=0.0.0.0"]