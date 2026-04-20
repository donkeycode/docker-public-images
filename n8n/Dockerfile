FROM alpine:3.22 AS bash-builder
RUN apk add --no-cache bash

FROM docker.n8n.io/n8nio/n8n:2.5.1

USER root
COPY --from=bash-builder /bin/bash /bin/bash
COPY --from=bash-builder /usr/lib/libreadline.so.8 /usr/lib/libreadline.so.8
COPY --from=bash-builder /usr/lib/libreadline.so.8.2 /usr/lib/libreadline.so.8.2
COPY --from=bash-builder /usr/lib/libncursesw.so.6 /usr/lib/libncursesw.so.6
COPY --from=bash-builder /usr/lib/libncursesw.so.6.5 /usr/lib/libncursesw.so.6.5

USER node 
COPY --chown=node:node --chmod=0755 start.sh            /usr/local/bin/dc-n8n-start
COPY --chown=node:node --chmod=0755 replace-env-file.sh /usr/local/bin/dc-replace-env
COPY --chown=node:node --chmod=0755 entrypoint.sh       /usr/local/bin/dc-entrypoint

ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

ENTRYPOINT ["/usr/local/bin/dc-entrypoint"]
CMD ["dc-n8n-start"]
