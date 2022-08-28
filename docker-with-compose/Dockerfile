FROM docker:20.10-git

RUN apk --update add py-pip openssl ca-certificates curl

RUN pip install \
    docker-compose==1.20.1 \
    awscli==1.19.0

