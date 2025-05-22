#!/bin/bash


REPO_DIR="/tmp/ci-repo"
LAST_COMMIT_FILE="/tmp/last_commit.txt"

mkdir -p "$REPO_DIR"
cd "$REPO_DIR" || exit 1

while true; do
    git clone --quiet --branch "$BRANCH" --depth 1 "$REPO_URL" . 2>/dev/null || git pull origin "$BRANCH"
    LATEST_COMMIT=$(git rev-parse HEAD)

    if [ ! -f "$LAST_COMMIT_FILE" ] || [ "$LATEST_COMMIT" != "$(cat $LAST_COMMIT_FILE)" ]; then
        echo "$LATEST_COMMIT" > "$LAST_COMMIT_FILE"
        echo "🛠 New commit detected, Dagger pipeline executed..."
        dagger run python3 ci_pipeline.py
    else
        echo "✅ No change detected."
    fi

    sleep 60
done
