FROM debian:12-slim

RUN apt update && apt install -y nginx openssl && apt clean

COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY tools/generate_cert.sh /generate_cert.sh

RUN chmod +x /generate_cert.sh && /generate_cert.sh

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
