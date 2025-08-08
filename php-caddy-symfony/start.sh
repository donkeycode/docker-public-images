#!/bin/bash
source /usr/local/bin/replace-env-file.sh

if [ "$CACHE" = "cache" ]; then
    export CACHE="$(cat /etc/souin.conf)"
elif [ "$CACHE" = "" ]; then
    export CACHE=""
fi

envsubst < /etc/$TEMPLATE > /etc/Caddyfile
caddy fmt --overwrite /etc/Caddyfile
cat /etc/Caddyfile
php-fpm &
/usr/sbin/caddy run --config /etc/Caddyfile
