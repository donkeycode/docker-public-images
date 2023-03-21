#!/bin/sh

sh /usr/local/bin/replace-env-file.sh

source /etc/environment

exec "$@"