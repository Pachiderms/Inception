FROM debian:13.0

RUN apt update -y && apt upgrade -y
RUN apt -y install php-fpm \
    php-mysql \
    curl

COPY ./tools/wp-ep.sh /
RUN chmod +x /wp-ep.sh
ENTRYPOINT [ "/wp-ep.sh" ]
