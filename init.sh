#!/bin/bash
set -ea

DB_HOST=${DB_HOST:-$MYSQL_PORT_3306_TCP_ADDR}
DB_USER=${DB_USER:-$MYSQL_ENV_MYSQL_USER}
DB_NAME=${DB_NAME:-$MYSQL_ENV_MYSQL_DATABASE}
DB_PASS=${DB_PASS:-$MYSQL_ENV_MYSQL_PASSWORD}

if [ ! -f /var/www/html/api/config.php ] && [ -n "$DB_HOST" ]; then
    echo Running autoconfig script...
    chmod +x /var/www/html/installation/init.php
    sync # see: https://github.com/docker/docker/issues/9547
    cd /var/www/html/installation/
    ./init.php
fi

apache2-foreground
