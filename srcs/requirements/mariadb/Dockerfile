FROM debian:13.0

RUN apt-get update
RUN apt-get install mariadb-server -y mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/lib/mysql \
    && mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

COPY ./tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["mysqld", "--bind-adress=0.0.0.0"]
