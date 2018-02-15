build:
	echo "Prepare building ${package}"
	docker build -t donkeycode/${package} ${package}
	docker push donkeycode/${package}