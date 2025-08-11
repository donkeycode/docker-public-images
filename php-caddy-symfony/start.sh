#!/bin/bash
source /usr/local/bin/replace-env-file.sh
envsubst < /etc/$TEMPLATE > /etc/Caddyfile
cat /etc/Caddyfile
php-fpm &
/usr/sbin/caddy run --config /etc/Caddyfile
