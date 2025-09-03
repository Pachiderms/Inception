#!/usr/bin/env bash
set -euo pipefail

: "${WORDPRESS_DB_HOST:?}"
: "${WORDPRESS_DB_USER:?}"
: "${WORDPRESS_DB_PASSWORD:?}"
: "${WORDPRESS_DB_NAME:?}"

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
  echo "Installing WordPress files..."
  curl -L https://wordpress.org/latest.tar.gz | tar xz --strip-components=1

  cp wp-config-sample.php wp-config.php

  sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php
  sed -i "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php
  sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php
  sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php

  # Salts (simple: random via openssl)
  SALT=$(openssl rand -base64 48 | tr -d '\n')
  for k in AUTH_KEY SECURE_AUTH_KEY LOGGED_IN_KEY NONCE_KEY AUTH_SALT SECURE_AUTH_SALT LOGGED_IN_SALT NONCE_SALT; do
    sed -i "s/define( '$k'.*/define( '$k', '${SALT}' );/" wp-config.php || true
  done

  chown -R root:root /var/www/html
  find /var/www/html -type d -exec chmod 755 {} \;
  find /var/www/html -type f -exec chmod 644 {} \;
fi

exec php-fpm82 -F