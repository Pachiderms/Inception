#!/bin/sh
set -e
mkdir -p /etc/nginx/certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048   -keyout /etc/nginx/certs/selfsigned.key   -out /etc/nginx/certs/selfsigned.crt   -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=${DOMAIN_NAME}"
