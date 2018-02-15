FROM alpine:3.6

RUN apk add --update nginx bash
RUN rm -rf /var/cache/apk/* && rm -rf /tmp/*

COPY nginx.conf /etc/nginx/
COPY default.conf /etc/nginx/conf.d/

RUN echo "upstream php-upstream { server php:9001; }" > /etc/nginx/conf.d/upstream.conf

RUN adduser -D -g '' -G www-data www-data

VOLUME [ "/var/www/symfony" ]

CMD ["nginx"]

RUN mkdir -p /var/tmp/nginx && chmod -R 777 /var/tmp/nginx

EXPOSE 80
EXPOSE 443