FROM donkeycode/docker-with-compose

RUN apk update && apk --no-cache add ruby ruby-dev ruby-bundler ruby-json ruby-irb ruby-rake ruby-bigdecimal libffi-dev clang gcc g++ make mysql-client mysql-dev zip

RUN mkdir /opt && cd /opt/ && wget https://chromedriver.storage.googleapis.com/2.33/chromedriver_linux64.zip && unzip chromedriver_linux64.zip && rm chromedriver_linux64.zip

RUN echo "http://dl-4.alpinelinux.org/alpine/v3.4/main" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories

RUN apk update && \
    apk add python py-pip curl unzip libexif udev chromium chromium-chromedriver xvfb && \
    pip install selenium && \
    pip install pyvirtualdisplay
