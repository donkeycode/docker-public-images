FROM prooph/php:7.1-fpm

RUN apk update && apk add make curl 

RUN curl --insecure https://getcomposer.org/composer.phar -o /usr/bin/composer && chmod +x /usr/bin/composer

COPY symfony.ini /usr/local/etc/php/conf.d/
ADD symfony.ini /etc/php7/php-fpm.d/
ADD symfony.ini /etc/php7/cli/conf.d/

COPY symfony.pool.conf /usr/local/etc/pool.d/

# Possible values for ext-name:
# bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash iconv imap interbase intl
# json ldap mbstring mcrypt mssql mysql mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci
# pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline recode reflection session shmop simplexml snmp soap
# sockets spl standard sybase_ct sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip

RUN docker-php-ext-configure iconv
RUN docker-php-ext-install iconv
RUN docker-php-ext-configure xml
RUN docker-php-ext-install xml
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip

RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

RUN apk add --update mysql mysql-client

RUN apk add --update freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev libxml2-dev autoconf g++ imagemagick-dev libtool \
    && docker-php-ext-install gd \
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install opcache \
    && docker-php-ext-install soap \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf g++ libtool \
    && rm -rf /tmp/* /var/cache/apk/*

WORKDIR /var/www/symfony
EXPOSE 9001

RUN apk update && apk add -y python py-pip && pip install --upgrade awscli && mkdir -p /root/.aws/