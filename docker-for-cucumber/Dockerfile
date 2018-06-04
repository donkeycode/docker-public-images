FROM elgalu/selenium

USER root
RUN apt-get update && apt-get install -y ruby ruby-dev rubygems libffi-dev clang gcc g++ make mysql-client libmysqld-dev zip

RUN apt-get install -y apt-transport-https ca-certificates curl software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install -y docker-ce
RUN curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

RUN cd /opt/ && curl https://chromedriver.storage.googleapis.com/2.33/chromedriver_linux64.zip --output chromedriver_linux64.zip && unzip -o chromedriver_linux64.zip && rm chromedriver_linux64.zip

RUN gem install bundler --no-document

RUN apt-get install -y python python-pip

RUN pip install awscli 

USER seluser
