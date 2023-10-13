IMAGE_NAME=crccheck/hello-world
CONTAINER_NAME=hello-world-with-run-web
ARCH=$(shell uname -m)
ifeq ($(ARCH),arm64)
	PLATFORM_PARAM := --platform linux/amd64
else
	PLATFORM_PARAM := 
endif
docker-run-up:
	docker pull $(IMAGE_NAME)
	sleep 2
	docker run -d --rm --name $(CONTAINER_NAME) $(PLATFORM_PARAM) -p 80:8000 $(IMAGE_NAME)

docker-run-down:
	docker stop $(CONTAINER_NAME)

docker-up:
	docker compose up

docker-down:
	docker compose down

docker-python-up:
	docker pull python
	docker run python
	docker ps
	docker ps -a
	docker run -it python bash
	docker run -d python sleep 30
	docker ps

docker-http-up:
	docker run -d -p 8080:80 --name=httpd-web httpd

docker-http-down:
	docker stop httpd-web
	sleep 2
	docker rm httpd-web

docker-mysql-up:
	docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mysecret -v ./data/host:/var/lib/mysql --name mysql-database mysql:latest

docker-mysql-down:
	docker stop mysql-database
	sleep 2
	docker rm mysql-database

docker-inspect:
	docker inspect $(CONTAINER_NAME)
	
docker-inspect-report:
	if [ -d "report" ]; \
	then echo "The report folder existed"; \
	else echo "The report folder doesn't exist"; \
	mkdir report; \
	echo "The report folder was created"; \
	fi
	docker inspect $(CONTAINER_NAME) > ./report/$(CONTAINER_NAME)_report.txt


docker-logs:
	docker logs $(CONTAINER_NAME)