#!/bin/bash

LAST_COMMIT_FILE="/ci/cache/last_commit.txt"

mkdir -p "$REPO_DIR"
cd "$REPO_DIR" || exit 1

mkdir -p "$SSH_DIR"
KEY_FILE="$SSH_DIR/id_ed25519"

if [ ! -f "$KEY_FILE" ]; then
    echo "🔐 Generate auth key..."
    ssh-keygen -t ed25519 -f "$KEY_FILE" -q -N ""
    echo ""
    echo "📎 Add this key in your github :"
    echo "---------------------------------------------------"
    cat "$KEY_FILE.pub"
    echo "---------------------------------------------------"
    echo ""
fi

export GIT_SSH_COMMAND="ssh -i $KEY_FILE -o StrictHostKeyChecking=no"

pip install --no-cache-dir -r /ci/pipeline/requirements.txt

while true; do
    if [ ! -d "$REPO_DIR/.git" ]; then
        echo "📦 Try clone repo..."
        rm -rf "$REPO_DIR"/* 2>/dev/null
        git clone --quiet --branch "$BRANCH" "$REPO_URL" "$REPO_DIR" || {
            echo "❌ Fail have u allowed the ssh key ?"
            sleep 60
            continue
        }
    else
        git fetch origin "$BRANCH"
        git reset --hard "origin/$BRANCH"
    fi

    LATEST_COMMIT=$(git rev-parse HEAD)

    if [ ! -f "$LAST_COMMIT_FILE" ] || [ "$LATEST_COMMIT" != "$(cat $LAST_COMMIT_FILE)" ]; then
        echo "$LATEST_COMMIT" > "$LAST_COMMIT_FILE"
        echo "🛠 New commit run dagger..."
        dagger run python3 /ci/pipeline/pipeline.py
    else
        echo "✅ No changes found"
    fi

    echo "✅ Clean docker for free spaces"
    docker rm -f $(docker ps -q --filter "name=dagger-engine-*")
    docker system prune -af
    docker volume prune -f

    sleep 60
done
