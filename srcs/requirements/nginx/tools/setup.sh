#!/usr/bin/env bash
set -euo pipefail

: "${DOMAIN_NAME:?DOMAIN_NAME must be set}"

echo "==> DOMAIN_NAME=${DOMAIN_NAME}" 

# Générer le certificat auto-signé s'il n'existe pas déjà
if [ ! -f /etc/nginx/ssl/nginx.crt ] || [ ! -f /etc/nginx/ssl/nginx.key ]; then
  echo "==> Génération du certificat SSL pour ${DOMAIN_NAME}"
  openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=Student/CN=${DOMAIN_NAME}"
fi

# Injecter la valeur du domaine dans la config nginx
if grep -q "__DOMAIN__" /etc/nginx/nginx.conf; then
  sed -i "s/__DOMAIN__/${DOMAIN_NAME}/g" /etc/nginx/nginx.conf
echo "==> nginx.conf mis à jour avec server_name ${DOMAIN_NAME}"
fi

echo "==> Démarrage de Nginx avec TLS activé"
exec nginx -g "daemon off;"