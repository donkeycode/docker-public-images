FROM quay.io/keycloak/keycloak:23.0.3

ENV DB_VENDOR mysql

COPY start.sh replace-env-file.sh entrypoint.sh /usr/local/bin/

ENV ENV=/etc/environment

ENTRYPOINT ["/bin/sh", "/usr/local/bin/entrypoint.sh"]

CMD ["/bin/sh", "/usr/local/bin/start.sh"]
