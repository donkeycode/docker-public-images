import dagger
import os

REPO_DIR = "/ci/cache/repository"

with dagger.Connection() as client:
    def clone_repo():
        print("📥 Clone repository...")
        return client.host().directory(REPO_DIR)
    
    src = clone_repo()
