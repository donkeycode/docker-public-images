FROM donkeycode/php-caddy-symfony:8.2-fpm

ENV REVIVE_VERSION 5.4.1

ENV WEBDIR /var/www/revive/www
ENV DB_PORT 3306

VOLUME /var/www/revive/var
VOLUME /var/www/revive/plugins
VOLUME /var/www/revive/www/admin/plugins
VOLUME /var/www/revive/www/images	

RUN cd / && \
    wget https://download.revive-adserver.com/revive-adserver-${REVIVE_VERSION}.zip && \
    unzip revive-adserver-${REVIVE_VERSION}.zip && \
    rm -f revive-adserver-${REVIVE_VERSION}.zip && \
    mv revive-adserver-${REVIVE_VERSION} /var/www/revive && \
    chmod -R a+w /var/www/revive/plugins && \
    chmod -R a+w /var/www/revive/www/admin/plugins && \
    chmod -R a+w /var/www/revive/var && \
    rm -rf /var/www/symfony && \
    cd /var/www/revive && \
    composer install

COPY Caddyfile.template /etc/Caddyfile.template

WORKDIR /var/www/revive
