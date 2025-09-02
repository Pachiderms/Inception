FROM alpine:3.19

RUN apk add --no-cache nginx openssl bash

RUN mkdir -p /var/ww/html /etc/nginx/ssl


COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY tools/setup.sh /tools/setup.sh
RUN chmod +x /tools/setup.sh

EXPOSE 443
ENTRYPOINT ["/tools/setup.sh"]
