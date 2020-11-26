FROM wordpress:php7.4-apache

COPY uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY opcache.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
COPY mpm_prefork.conf /etc/apache2/mods-enabled/mpm_prefork.conf
