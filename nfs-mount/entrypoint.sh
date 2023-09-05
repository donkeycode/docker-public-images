#!/bin/sh

if [ -n "$NFS_SERVER" ] && [ -n "$MOUNT_DIR" ]; then
    echo "Mounting NFS share..."
    mkdir -p "/mnt/nfs_mount"
    mount -t nfs -o "$MOUNT_OPTS" "$NFS_SERVER:$MOUNT_DIR" "/mnt/nfs_mount"
    
    echo "Container is running."
    while true; do
        sleep 1
    done
else
    echo "NFS_SERVER and MOUNT_DIR must be defined."
fi
