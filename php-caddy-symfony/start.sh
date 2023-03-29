#!/bin/bash
source /usr/local/bin/replace-env-file.sh
envsubst < /etc/Caddyfile.template > /etc/Caddyfile
caddy fmt --overwrite /etc/Caddyfile
cat /etc/Caddyfile
php-fpm &
/usr/sbin/caddy run --config /etc/Caddyfile
