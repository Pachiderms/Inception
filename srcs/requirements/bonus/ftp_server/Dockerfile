FROM debian:bookworm

RUN	apt update && apt upgrade && apt install -y \
        vsftpd

COPY conf/vsftpd.conf /tmp/vsftpd.conf

COPY tools/server_ftp.sh /tmp/server_ftp.sh
ENTRYPOINT ["sh", "/tmp/server_ftp.sh"]
