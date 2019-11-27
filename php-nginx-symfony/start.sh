#!/bin/bash
php-fpm &
envsubst < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && cat /etc/nginx/conf.d/default.conf && nginx