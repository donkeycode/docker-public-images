#!/bin/bash
source /usr/local/bin/replace-env-file.sh
envsubst < /etc/Caddyfile.template > /etc/Caddyfile
caddy fmt --overwrite /etc/Caddyfile
cat /etc/Caddyfile

# Copy ini files
for file in /var/www/php.d/*; do
    ln -s "$file" /usr/local/etc/php/conf.d/
done

php-fpm &

if [ -n "$REVIVE_DOMAIN" ]; then
    mkdir /etc/cron.d/
    envsubst < /etc/crontab.template > /etc/cron.d/commander-cron
    chmod 0644 /etc/cron.d/commander-cron
    crontab /etc/cron.d/commander-cron
    echo "Cron job installed."
else
    echo "Variable REVIVE_DOMAIN not defined. No cronjobs defined"
fi

/usr/sbin/crond -f -d 0 &
/usr/sbin/caddy run --config /etc/Caddyfile
