build:
	lein do clean, uberjar
	
docker-build: 
	# docker build --build-arg BUILD_NO=111 --build-arg SERVICE_NAME=batch -t batch .
	docker-compose build

start:
	docker-compose up
	docker-compose scale batch_vur=2

