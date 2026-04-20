# Image `donkeycode/postiz`

Image basée sur [`ghcr.io/gitroomhq/postiz-app`](https://github.com/gitroomhq/postiz-app), avec le même principe que les autres projets du dépôt : chargement des secrets depuis des fichiers via les variables `*_SECRET_FILE` (script `dc-replace-env` au démarrage).

## Variables d’environnement indispensables

Postiz attend au minimum :

| Variable | Description |
|----------|-------------|
| `DATABASE_URL` | URL PostgreSQL complète, ex. `postgresql://user:pass@hôte:5432/base` |
| `REDIS_URL` | URL Redis complète, ex. `redis://redis:6379` |
| `JWT_SECRET` | Secret pour signer les JWT (chaîne longue et unique) |
| `MAIN_URL` | URL publique d’accès à l’application |
| `FRONTEND_URL` | Idem / URL front (souvent identique à `MAIN_URL` derrière un reverse proxy) |
| `NEXT_PUBLIC_BACKEND_URL` | URL publique de l’API (ex. `https://postiz.example.com/api`) |
| `BACKEND_INTERNAL_URL` | URL interne du backend (souvent `http://localhost:3000` dans le conteneur) |
| `TEMPORAL_ADDRESS` | Adresse du serveur Temporal (ex. `temporal:7233` si Temporal est sur le même réseau Docker) |

Référence complète : [documentation Postiz — configuration](https://docs.postiz.com/configuration/reference).

## Secrets dans des fichiers (`*_SECRET_FILE`)

Comme pour `n8n` ou d’autres images du dépôt, vous pouvez exposer un chemin de fichier plutôt que la valeur en clair :

```bash
DATABASE_URL_SECRET_FILE=/run/secrets/database_url
JWT_SECRET_SECRET_FILE=/run/secrets/jwt_secret
```

Le script charge le contenu du fichier et exporte `DATABASE_URL` / `JWT_SECRET` sans le suffixe `_SECRET_FILE`.

## Build de l’image

```bash
# Image locale
docker build -t donkeycode/postiz:latest postiz

# Avec une version précise de l’image amont Postiz
docker build --build-arg POSTIZ_VERSION=v2.21.6 -t donkeycode/postiz:v2.21.6 postiz
```

Depuis la racine du dépôt (même convention que les autres paquets) :

```bash
make build-tag package=postiz tag=latest
```

## Exemple Docker Compose

L’exemple ci‑dessous lance Postiz avec PostgreSQL et Redis **dans le même compose**. Adaptez les URLs (`MAIN_URL`, `FRONTEND_URL`, `NEXT_PUBLIC_BACKEND_URL`) à votre domaine ou à `http://localhost:4007` en local.

**Temporal** n’est pas inclus ici : en production vous devez soit le déployer à part, soit reprendre la stack Temporal du [`docker-compose.yaml` officiel](https://github.com/gitroomhq/postiz-app/blob/main/docker-compose.yaml) et brancher `TEMPORAL_ADDRESS` dessus (souvent `temporal:7233` sur un réseau Docker commun).

```yaml
services:
  postiz:
    image: donkeycode/postiz:latest
    container_name: postiz
    restart: unless-stopped
    ports:
      - "4007:5000"
    environment:
      # URLs publiques — à adapter
      MAIN_URL: "http://localhost:4007"
      FRONTEND_URL: "http://localhost:4007"
      NEXT_PUBLIC_BACKEND_URL: "http://localhost:4007/api"
      BACKEND_INTERNAL_URL: "http://localhost:3000"

      # Base et cache — noms de services du compose
      DATABASE_URL: "postgresql://postiz:postiz-secret@postgres:5432/postiz"
      REDIS_URL: "redis://redis:6379"

      JWT_SECRET: "changez-moi-avec-une-longue-chaine-aleatoire"
      TEMPORAL_ADDRESS: "temporal:7233"
      IS_GENERAL: "true"
      DISABLE_REGISTRATION: "false"

      # Stockage local dans le conteneur (volumes ci-dessous)
      STORAGE_PROVIDER: "local"
      UPLOAD_DIRECTORY: "/uploads"
      NEXT_PUBLIC_UPLOAD_DIRECTORY: "/uploads"

    volumes:
      - postiz-config:/config
      - postiz-uploads:/uploads
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    networks:
      - postiz-net

  postgres:
    image: postgres:17-alpine
    container_name: postiz-postgres
    restart: unless-stopped
    environment:
      POSTGRES_USER: postiz
      POSTGRES_PASSWORD: postiz-secret
      POSTGRES_DB: postiz
    volumes:
      - postiz-pg-data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postiz -d postiz"]
      interval: 10s
      timeout: 3s
      retries: 3
    networks:
      - postiz-net

  redis:
    image: redis:7.2-alpine
    container_name: postiz-redis
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 3s
      retries: 3
    networks:
      - postiz-net

volumes:
  postiz-config:
  postiz-uploads:
  postiz-pg-data:

networks:
  postiz-net:
    driver: bridge
```

### Utiliser PostgreSQL / Redis externes

Supprimez les services `postgres` et `redis`, retirez `depends_on`, et définissez `DATABASE_URL` et `REDIS_URL` vers vos instances (managed cloud, autres stacks, etc.). Gardez un réseau Docker si Postiz doit joindre Temporal ou d’autres services par nom DNS interne.

### Fichier `.env` avec Compose

Vous pouvez externaliser les secrets dans un `.env` à côté du compose :

```env
DATABASE_URL=postgresql://postiz:motdepasse@postgres:5432/postiz
REDIS_URL=redis://redis:6379
JWT_SECRET=votre-secret-tres-long
```

Puis dans le compose, utilisez `${DATABASE_URL}` etc., sans commiter le `.env` versionné avec des vrais secrets.
