# Repositories for hub.docker.com/donkeycode

## Build a package

make build package=php-symfony

## Build a specific version

```
docker build -t donkeycode/php-nginx-symfony:7.2-fpm-wkhtmltopdf -f Dockerfile-7.2-fpm-wkhtmltopdf --no-cache .
```

## Scan 



docker scan ou https://aquasecurity.github.io/trivy/

