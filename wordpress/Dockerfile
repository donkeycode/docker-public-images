FROM wordpress:php8.2-fpm-alpine

COPY uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY opcache.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
#COPY mpm_prefork.conf /etc/apache2/mods-enabled/mpm_prefork.conf
RUN echo "expose_php = Off" > /usr/local/etc/php/conf.d/expose_php.ini

COPY crontab /var/www/crontab

## FROM https://github.com/nginxinc/docker-nginx/blob/a973c221f6cedede4dab3ab36d18240c4d3e3d74/mainline/alpine/Dockerfile
# ENV NGINX_VERSION 1.17.8
# ENV PKG_RELEASE   1

RUN set -eux; \
    # Créer un utilisateur et un groupe nginx
    addgroup -S -g 102 nginx; \
    adduser -S -D -H -u 102 -h /var/cache/nginx -s /sbin/nologin -G nginx -g "nginx user" nginx; \
    
    # Détection de l'architecture
    apkArch="$(apk --print-arch)"; \
    echo "Architecture détectée : $apkArch"; \
    
    # Paquet NGINX
    nginxPackages="nginx"; \
    
    # Installation des paquets nginx précompilés
    apk add --no-cache --virtual .cert-deps openssl; \
    apk add --no-cache -X "https://nginx.org/packages/mainline/alpine/v$(cut -d '.' -f 1-2 /etc/alpine-release)/main" $nginxPackages; \
    
    # Installation des dépendances de build
    apk add --no-cache --virtual .build-deps \
        gcc \
        libc-dev \
        make \
        openssl-dev \
        pcre-dev \
        zlib-dev \
        linux-headers \
        libxslt-dev \
        gd-dev \
        geoip-dev \
        perl-dev \
        libedit-dev \
        mercurial \
        bash \
        alpine-sdk \
        findutils; \
    
    apk add --no-cache --virtual .gettext gettext \
    && mv /usr/bin/envsubst /tmp/; \
    runDeps="$( \
        scanelf --needed --nobanner /tmp/envsubst \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
    )" \
    && apk add --no-cache $runDeps \
    && apk del .gettext; \
    # Déplacement de l'exécutable envsubst (le chemin doit être précisé)
    mv /tmp/envsubst /usr/local/bin/envsubst; \
    
    # Installation de tzdata
    apk add --no-cache tzdata; \
    
    # Configuration des logs nginx
    ln -sf /dev/stdout /var/log/nginx/access.log; \
    ln -sf /dev/stderr /var/log/nginx/error.log; \
    
    # Nettoyage des dépendances temporaires
    apk del .build-deps .cert-deps; \
    
    echo "Installation et configuration de nginx terminées."

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]

## END FROM 

ENV WEBDIR /var/www/html
ENV CONTROLLER_NAME index
ENV uri '$uri'
ENV dl '$'

COPY nginx.conf /etc/nginx/
COPY default.template /etc/nginx/conf.d/
COPY start.sh /usr/local/bin/
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

RUN echo "upstream php-upstream { server 127.0.0.1:9000; }" > /etc/nginx/conf.d/upstream.conf

VOLUME [ "/var/www/html" ]

RUN mkdir -p /var/tmp/nginx && chmod -R 777 /var/tmp/nginx 

COPY replace-env-file.sh /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/

CMD [ "/bin/sh", "/usr/local/bin/start.sh" ]

EXPOSE 80
EXPOSE 443

