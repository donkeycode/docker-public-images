ARG POSTIZ_VERSION=latest

FROM ghcr.io/gitroomhq/postiz-app:${POSTIZ_VERSION}

USER root
# Bash utilisable (glibc) — ne pas copier bash depuis Alpine : binaire musl, ne tourne pas sur Debian.
RUN apt-get update \
    && apt-get install -y --no-install-recommends bash \
    && rm -rf /var/lib/apt/lists/*

COPY --chmod=0755 replace-env-file.sh /usr/local/bin/dc-replace-env
COPY --chmod=0755 entrypoint.sh       /usr/local/bin/dc-entrypoint

ENTRYPOINT ["/usr/local/bin/dc-entrypoint"]
CMD ["sh", "-c", "nginx && pnpm run pm2"]
