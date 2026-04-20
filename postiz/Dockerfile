ARG TARGETPLATFORM
ARG POSTIZ_VERSION=latest

FROM --platform=${TARGETPLATFORM} alpine:3.22 AS bash-builder
RUN apk add --no-cache bash

FROM --platform=${TARGETPLATFORM} ghcr.io/gitroomhq/postiz-app:${POSTIZ_VERSION}

USER root
COPY --from=bash-builder /bin/bash /bin/bash
COPY --from=bash-builder /usr/lib/libreadline.so.8 /usr/lib/libreadline.so.8
COPY --from=bash-builder /usr/lib/libreadline.so.8.2 /usr/lib/libreadline.so.8.2
COPY --from=bash-builder /usr/lib/libncursesw.so.6 /usr/lib/libncursesw.so.6
COPY --from=bash-builder /usr/lib/libncursesw.so.6.5 /usr/lib/libncursesw.so.6.5

COPY --chmod=0755 replace-env-file.sh /usr/local/bin/dc-replace-env
COPY --chmod=0755 entrypoint.sh       /usr/local/bin/dc-entrypoint

ENTRYPOINT ["/usr/local/bin/dc-entrypoint"]
CMD ["sh", "-c", "nginx && pnpm run pm2"]
