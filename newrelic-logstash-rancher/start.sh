#!/bin/bash
source /usr/local/bin/replace-env-file.sh
envsubst < /usr/share/logstash/config/logstash.conf.template > /usr/share/logstash/config/logstash.conf && cat /usr/share/logstash/config/logstash.conf
cp /usr/share/logstash/config/logstash.conf /usr/share/logstash/pipeline/logstash.conf
logstash