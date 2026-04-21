ARG MIXPOST_VERSION=latest

FROM inovector/mixpost:${MIXPOST_VERSION}

USER root

COPY --chmod=0755 replace-env-file.sh /usr/local/bin/dc-replace-env
COPY --chmod=0755 entrypoint.sh /usr/local/bin/dc-entrypoint

ENTRYPOINT ["/usr/local/bin/dc-entrypoint"]
