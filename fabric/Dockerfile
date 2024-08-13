FROM python:3.9.19-alpine

RUN apk add build-base libffi-dev openssh git patch
RUN pip install --upgrade pip && \
    pip install fabric python-dotenv
RUN echo "Started" > /var/log/fake.log
CMD ["tail", "-f", "/var/log/fake.log"]
