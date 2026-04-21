# Image `donkeycode/mixpost`

Image basée sur [`inovector/mixpost`](https://hub.docker.com/r/inovector/mixpost), avec le même principe que les autres projets du dépôt : chargement des secrets depuis des fichiers via les variables `*_SECRET_FILE` (script `dc-replace-env` au démarrage).

Documentation officielle Mixpost Lite (Docker, variables, services) : [docs.mixpost.app — Installation Docker](https://docs.mixpost.app/lite/installation/docker).

## Variables `*_SECRET_FILE`

Pour toute variable d’environnement `NOM`, si `NOM_SECRET_FILE` pointe vers un fichier lisible, sa **valeur** est remplacée par le **contenu** du fichier au démarrage (export vers `NOM`). Utile pour les secrets Docker / Kubernetes / Rancher.

Exemples courants pour Mixpost :

| Variable fichier | Variable résolue | Usage |
|------------------|------------------|--------|
| `DB_PASSWORD_SECRET_FILE` | `DB_PASSWORD` | Mot de passe MySQL |
| `APP_KEY_SECRET_FILE` | `APP_KEY` | Clé Laravel (générateur : [encryption-key-generator](https://mixpost.app/tools/encryption-key-generator)) |
| `MAIL_PASSWORD_SECRET_FILE` | `MAIL_PASSWORD` | SMTP (si besoin) |

Les autres variables (`APP_URL`, `DB_HOST`, `REDIS_HOST`, etc.) restent des variables d’environnement classiques.

## Build local

```bash
docker build -t donkeycode/mixpost:latest mixpost
# ou version upstream précise :
docker build --build-arg MIXPOST_VERSION=latest -t donkeycode/mixpost:latest mixpost
```

Via le `Makefile` du dépôt :

```bash
make build-tag package=mixpost tag=latest
```

## Compose d’exemple

Voir `docker-compose.example.yaml` (plugin `docker compose`, spec Compose v2+). Copier `env.example` vers `.env`, créer les fichiers sous `secrets/`, puis :

```bash
docker compose -f docker-compose.example.yaml --env-file .env up -d
```

Identifiants par défaut de l’application (à changer après la première connexion) : voir la doc officielle (compte admin `admin@example.com` / mot de passe initial indiqué dans la doc Mixpost).

## Compte par défaut

La doc Mixpost indique un utilisateur admin par défaut ; changez le mot de passe depuis l’interface après installation.
