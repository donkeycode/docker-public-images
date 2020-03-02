FROM python:2.7-alpine3.11

ENV PATH="/root/.local/bin:$PATH"
ENV PYTHONIOENCODING=UTF-8
ENV TIMEZONE="Europe/Paris"

RUN apk add --no-cache gcc musl-dev libffi-dev openssl-dev make jq zip git wget nodejs tzdata openssh-client

RUN pip install 'fabric<2.0'
RUN echo $TIMEZONE > /etc/timezone
