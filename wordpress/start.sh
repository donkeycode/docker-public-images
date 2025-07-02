#!/usr/bin/env bash
source /usr/local/bin/replace-env-file.sh
php-fpm &
crontab /var/www/crontab
envsubst < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf
cat /etc/nginx/conf.d/default.conf
nginx
