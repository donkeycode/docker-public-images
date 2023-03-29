#!/bin/bash
source /usr/local/bin/replace-env-file.sh
envsubst < /etc/Caddyfile.template > /etc/Caddyfile && cat /etc/Caddyfile
/usr/sbin/caddy run --config /etc/Caddyfile
