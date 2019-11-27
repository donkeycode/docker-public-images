FROM donkeycode/php-symfony:7.2-fpm

ENV CONTROLLER_NAME app_dev
ENV uri '$uri'
ENV dl '$'

COPY nginx.conf /etc/nginx/
COPY default.template /etc/nginx/conf.d/
COPY start.sh /usr/local/bin/

RUN echo "upstream php-upstream { server 127.0.0.1:9001; }" > /etc/nginx/conf.d/upstream.conf

VOLUME [ "/var/www/symfony" ]

RUN mkdir -p /var/tmp/nginx && chmod -R 777 /var/tmp/nginx 

CMD [ "/bin/sh", "/usr/local/bin/start.sh" ]

EXPOSE 80
EXPOSE 443