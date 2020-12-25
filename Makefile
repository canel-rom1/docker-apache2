NAME    	?= apache2
CONTAINER	?= $(NAME)
REPO  		?= canelrom1
IMAGE		?= $(REPO)/$(NAME)
TAG     	?= $(shell date +%Y%m%d.%H%M%S)

HTTP_PORT  		= 80
HTTPS_PORT 		= 443
CONTAINER_HTTP_PORT  	= 80
CONTAINER_HTTPS_PORT 	= 443

BUILD_DIR = ./src
USE_SHELL = sh


all: build

build: src/Dockerfile
	docker build -t $(IMAGE):$(TAG) $(BUILD_DIR)
	docker tag $(IMAGE):$(TAG) $(IMAGE):latest 

newbuild: src/Dockerfile
	docker build --pull -t $(IMAGE):$(TAG) $(BUILD_DIR)
	docker tag $(IMAGE):$(TAG) $(IMAGE):latest 

run:
	docker run -it --rm $(IMAGE):latest $(USE_SHELL)

start:
	docker run -d --name $(CONTAINER) \
		-p $(HTTP_PORT):$(CONTAINER_HTTP_PORT) \
		-p $(HTTPS_PORT):$(CONTAINER_HTTPS_PORT) \
		$(IMAGE):latest

stop:
	docker stop $(CONTAINER)

rm: stop
	docker rm $(CONTAINER)

shell:
	docker exec -it $(CONTAINER) $(USE_SHELL)


# vim: ft=make
