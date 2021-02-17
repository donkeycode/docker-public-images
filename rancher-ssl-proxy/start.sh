#!/bin/bash

cd /

openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
openssl rsa -passin pass:x -in server.pass.key -out server.key
rm server.pass.key
openssl req -new -key server.key -out server.csr \
    -subj "/C=FR/ST=DonkeyCode/L=DonkeyCode/O=DonkeyCode/OU=IT Department/CN=${SERVER_NAME}"
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt


envsubst < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && cat /etc/nginx/conf.d/default.conf && nginx
