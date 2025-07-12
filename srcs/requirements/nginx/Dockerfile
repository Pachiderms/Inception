FROM alpine:latest

RUN apk update && apk add nginx openssl

WORKDIR /var/www/html

COPY tools /tools
RUN chmod +x /tools/setup.sh

EXPOSE 443

CMD["nginx", "-g", "daemon off;"]