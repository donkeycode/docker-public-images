FROM ubuntu:16.04

ENV TIMEZONE="Europe/Paris"
RUN apt-get update
RUN apt-get install -y wget tzdata
RUN echo $TIMEZONE > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y python-pip && pip install fabric==1.14.0

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y build-essential nodejs
