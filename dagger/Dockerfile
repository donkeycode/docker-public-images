FROM python:3.13-alpine3.21

ENV REPO_URL="git@github.com:ton-org/ton-repo.git"
ENV BRANCH="main"

RUN apk add --no-cache git curl && \
    pip install --no-cache-dir dagger-io

WORKDIR /ci
COPY ci_pipeline.py /ci/ci_pipeline.py
COPY ci_watch.sh /ci/ci_watch.sh

VOLUME ["/ci/cache"]

CMD ["/bin/sh", "/ci/ci_watch.sh"]
