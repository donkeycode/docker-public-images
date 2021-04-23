build:
	echo "Prepare building ${package}"
	docker build -t donkeycode/${package} ${package}
	docker push donkeycode/${package}

build-php:
	docker build -t donkeycode/php:${version}-fpm -f php/Dockerfile-${version}-fpm php
	docker push donkeycode/php:${version}-fpm

build-symfony:
	docker build -t donkeycode/php-symfony:${version}-fpm -f php-symfony/Dockerfile-${version}-fpm php-symfony
	docker push donkeycode/php-symfony:${version}-fpm

	docker build -t donkeycode/php-nginx-symfony:${version}-fpm -f php-nginx-symfony/Dockerfile-${version} php-nginx-symfony
	docker push donkeycode/php-nginx-symfony:${version}-fpm

build-php-symfony:
	make build-php version=${version}
	make build-symfony version=${version}
