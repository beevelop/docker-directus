#!/bin/bash
set -ea

DB_HOST=${DB_HOST:-$MYSQL_PORT_3306_TCP_ADDR}
DB_USER=${DB_USER:-$MYSQL_ENV_MYSQL_USER}
DB_NAME=${DB_NAME:-$MYSQL_ENV_MYSQL_DATABASE}
DB_PASS=${DB_PASS:-$MYSQL_ENV_MYSQL_PASSWORD}
DB_PORT=${DB_PORT:-$MYSQL_PORT_3306_TCP_PORT}
DB_PORT=${DB_PORT:-3306}

while ! nc -z $DB_HOST $DB_PORT; do
  echo "Waiting for Database $DB_HOST:$DB_PORT..."
  sleep 2
done

if [ ! -f /var/www/html/api/config.php ] && [ -n "$DB_HOST" ]; then
    echo Running autoconfig script...
    sync # see: https://github.com/docker/docker/issues/9547
    cd /var/www/html/bin/

    # Write config file with DB envs
    ./directus config --host=$DB_HOST --name=$DB_NAME --user=$DB_USER --pass=$DB_PASS
    # Initialize database
    ./directus database
    # Setup Admin
    ./directus install -e=$ADMIN_EMAIL -p=$ADMIN_PASSWORD -t=$SITE_NAME
fi

apache2-foreground
