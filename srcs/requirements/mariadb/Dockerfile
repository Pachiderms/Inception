FROM alpine:3.19

RUN apk add --no-cache mariadb mariadb-client bash

# Dossier data (monté par volume) + conf
RUN mkdir -p /var/lib/mysql /run/mysqld && chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306
USER mysql
ENTRYPOINT ["/entrypoint.sh"]