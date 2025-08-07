build:
	make build-tag package=${package} tag=latest

build-tag:
	echo "Prepare building ${package}"
	docker build -t donkeycode/${package}:${tag} ${package}
	docker push donkeycode/${package}:${tag}

build-php:
	docker build -t donkeycode/php:${version}-fpm -f php/Dockerfile-${version}-fpm php
	docker push donkeycode/php:${version}-fpm

build-caddy-symfony:
	docker build -t donkeycode/php-caddy-symfony:${version}-fpm -f php-caddy-symfony/Dockerfile-${version} php-caddy-symfony
	docker push donkeycode/php-caddy-symfony:${version}-fpm

build-caddy-symfony-souin:
	docker build -t donkeycode/php-caddy-symfony-souin:${version}-souin -f php-caddy-symfony/Dockerfile-${version}-souin php-caddy-symfony
	docker push donkeycode/php-caddy-symfony-souin:${version}-souin

build-symfony:
	docker build -t donkeycode/php-symfony:${version}-fpm -f php-symfony/Dockerfile-${version}-fpm php-symfony
	docker push donkeycode/php-symfony:${version}-fpm

	docker build -t donkeycode/php-nginx-symfony:${version}-fpm -f php-nginx-symfony/Dockerfile-${version} php-nginx-symfony
	docker push donkeycode/php-nginx-symfony:${version}-fpm

build-symfony-wkhtmltopdf:
	docker build -t donkeycode/php-symfony:${version}-fpm-wkhtmltopdf -f php-symfony/Dockerfile-${version}-fpm-wkhtmltopdf php-symfony
	docker push donkeycode/php-symfony:${version}-fpm-wkhtmltopdf

	docker build -t donkeycode/php-nginx-symfony:${version}-fpm-wkhtmltopdf -f php-nginx-symfony/Dockerfile-${version}-fpm-wkhtmltopdf php-nginx-symfony
	docker push donkeycode/php-nginx-symfony:${version}-fpm-wkhtmltopdf

build-php-symfony:
	make build-php version=${version}
	make build-symfony version=${version}
	make build-symfony-wkhtmltopdf version=${version}

build-old-alpine:
	docker build -t donkeycode/php:${version}-fpm-alpine3.13-20211215 -f php/Dockerfile-${version}-fpm-alpine3.13 php
	docker push donkeycode/php:${version}-fpm-alpine3.13-20211215

	docker build -t donkeycode/php-symfony:${version}-fpm-alpine3.13-20211215 -f php-symfony/Dockerfile-${version}-fpm-alpine3.13 php-symfony
	docker push donkeycode/php-symfony:${version}-fpm-alpine3.13-20211215

	docker build -t donkeycode/php-symfony:${version}-fpm-wkhtmltopdf-alpine3.13-20211215 -f php-symfony/Dockerfile-${version}-fpm-wkhtmltopdf-alpine3.13 php-symfony
	docker push donkeycode/php-symfony:${version}-fpm-wkhtmltopdf-alpine3.13-20211215

	docker build -t donkeycode/php-nginx-symfony:${version}-fpm-wkhtmltopdf-alpine3.13-20211215 -f php-nginx-symfony/Dockerfile-${version}-fpm-wkhtmltopdf-alpine3.13 php-nginx-symfony
	docker push donkeycode/php-nginx-symfony:${version}-fpm-wkhtmltopdf-alpine3.13-20211215

build-revive:
	make build-tag package=revive-adserver tag=5.5.2
