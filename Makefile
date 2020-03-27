prefix  ?= canelrom1
name    ?= apache2
tag     ?= $(shell date +%Y%m%d.%H%M%S)

build_dir = src
use_shell = sh

http_port  = 80
https_port = 443


all: build

run:
	docker run -it --rm $(prefix)/$(name):latest $(use_shell)

build: src/Dockerfile
	docker build -t $(prefix)/$(name):$(tag) $(build_dir)
	docker tag $(prefix)/$(name):$(tag) $(prefix)/$(name):latest 

newbuild: src/Dockerfile
	docker build --pull -t $(prefix)/$(name):$(tag) $(build_dir)
	docker tag $(prefix)/$(name):$(tag) $(prefix)/$(name):latest 

start:
	docker run -d -p $(http_port):80 -p $(https_port):443 --name $(name) $(prefix)/$(name):latest

stop:
	docker stop $(name)

rm: stop
	docker rm $(name)

clean-docker: clean-docker-latest
	docker rmi $(prefix)/$(name):$(tag)

clean-docker-latest:
	docker rmi $(prefix)/$(name):latest

clean: clean-docker clean-old-images

monitor:
	docker exec -it $(name) $(use_shell)


# vim: ft=make
