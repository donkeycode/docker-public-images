#!/bin/bash
source /usr/local/bin/replace-env-file.sh

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
