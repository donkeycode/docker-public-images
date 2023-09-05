FROM alpine:latest

# Installe les outils nécessaires
RUN apk --update add nfs-utils

ENV HOST_MOUNT_PATH="/mnt/nfs_mount" 

# Script d'entrée
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
