FROM nginx:1.21-alpine

ENV dl '$'
ENV SERVER_NAME 'donkeycode.tech'

COPY nginx.conf /etc/nginx/
COPY default.template /etc/nginx/conf.d/
COPY start.sh /usr/local/bin/

CMD [ "/bin/sh", "/usr/local/bin/start.sh" ]

EXPOSE 443
