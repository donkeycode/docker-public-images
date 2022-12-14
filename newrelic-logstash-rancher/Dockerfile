FROM logstash:8.5.1

RUN logstash-plugin install logstash-output-newrelic

USER root
RUN apt install -y gettext-base

USER logstash

COPY logstash.conf.template logstash.yml /usr/share/logstash/config/
COPY start.sh replace-env-file.sh entrypoint.sh /usr/local/bin/

ENV ENV="/usr/share/logstash/myenvironment"

ENTRYPOINT [  "/bin/sh", "/usr/local/bin/entrypoint.sh" ]
CMD [ "/bin/sh", "/usr/local/bin/start.sh" ]