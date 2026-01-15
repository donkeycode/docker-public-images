FROM nginx:1.20-alpine

EXPOSE 43
ENV PROXY_PASS http://localhost:8080

WORKDIR /var/www/html

RUN apk update && apk add openjdk11

COPY localhost.crt /etc/nginx/ssl/localhost.crt
COPY localhost.key /etc/nginx/ssl/localhost.key
COPY default.template /etc/nginx/conf.d/
COPY run.sh /run.sh
COPY nginx.conf /etc/nginx/

CMD [ "sh", "/run.sh" ]