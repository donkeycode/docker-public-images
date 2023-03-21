FROM moodlehq/moodle-php-apache:8.2-buster

RUN echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

COPY start.sh replace-env-file.sh entrypoint.sh /usr/local/bin/

ENV ENV=/etc/environment

ENTRYPOINT ["/bin/sh", "/usr/local/bin/entrypoint.sh"]

CMD ["/bin/sh", "/usr/local/bin/start.sh"]