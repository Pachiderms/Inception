FROM debian:13.0

RUN apt update
RUN apt-get install mariadb-server -y \
    mariadb-client \

#RUN rm -rf /var/lib/apt/lists/*

#RUN mkdir -p /var/run/mysqld \
#    && chown -R mysql:mysql /var/run/mysqld \
#    && chmod 777 /var/run/mysqld

RUN rm -rf /var/lib/apt/lists/*; \
# comment out any "user" entires in the MySQL config ("docker-entrypoint.sh" or "--user" will handle user switching)
	sed -ri 's/^user\s/#&/' /etc/mysql/my.cnf /etc/mysql/conf.d/*; \
# purge and re-create /var/lib/mysql with appropriate ownership
	rm -rf /var/lib/mysql; \
	mkdir -p /var/lib/mysql /var/run/mysqld; \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld; \
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
	chmod 777 /var/run/mysqld; \

#COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/mariadb-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/mariadb-entrypoint.sh /
#RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh
ENTRYPOINT ["mariadb-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
