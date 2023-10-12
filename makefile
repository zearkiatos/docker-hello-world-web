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