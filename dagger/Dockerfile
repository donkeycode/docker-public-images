FROM donkeycode/docker-with-compose:latest

ENV REPO_DIR="/ci/cache/repository"
ENV SSH_DIR="/ci/cache/.ssh"
ENV REPO_URL="git@github.com:ton-org/ton-repo.git"
ENV BRANCH="main"

RUN apk add --no-cache git curl && \
    curl -fsSL https://dl.dagger.io/dagger/install.sh | BIN_DIR=/usr/local/bin sh && \
    pip install dagger-io

WORKDIR /ci
COPY ./pipeline/ /ci/pipeline/
COPY ci_watch.sh /ci/ci_watch.sh

VOLUME ["/ci/cache"]

CMD ["/bin/sh", "/ci/ci_watch.sh"]
