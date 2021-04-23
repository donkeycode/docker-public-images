FROM alpine:3.13.5

RUN apk add --update curl && \
    curl -O https://releases.rancher.com/cli/v0.6.14/rancher-linux-amd64-v0.6.14.tar.gz && \
    tar -xzvf rancher-linux-amd64-v0.6.14.tar.gz && \
    rm -f rancher-linux-amd64-v0.6.14.tar.gz && \
    mv rancher-v0.6.14/rancher /usr/local/bin/rancher
