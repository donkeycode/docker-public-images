#!/bin/bash
source /usr/local/bin/replace-env-file.sh
php-fpm &
envsubst < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && cat /etc/nginx/conf.d/default.conf && nginx
