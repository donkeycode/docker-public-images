FROM docker.n8n.io/n8nio/n8n

USER root
RUN apk add bash

USER node 
COPY --chown=node:node --chmod=0755 start.sh            /usr/local/bin/dc-n8n-start
COPY --chown=node:node --chmod=0755 replace-env-file.sh /usr/local/bin/dc-replace-env
COPY --chown=node:node --chmod=0755 entrypoint.sh       /usr/local/bin/dc-entrypoint

ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

ENTRYPOINT ["/usr/local/bin/dc-entrypoint"]
CMD ["dc-n8n-start"]
