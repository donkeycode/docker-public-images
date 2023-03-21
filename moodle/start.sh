#!/bin/bash
sh /usr/local/bin/replace-env-file.sh

source /etc/environment

/opt/bitnami/scripts/moodle/run.sh