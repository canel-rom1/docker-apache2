prefix  ?= canelrom1
name    ?= apache
tag     ?= $(shell date +%y%m%d.%H%M%S)

env_file = ./environment.conf


all: build

run:
	docker run -it --name $(name) $(prefix)/$(name):latest sh

build: src/Dockerfile
	docker build -t $(prefix)/$(name):$(tag) src
	docker tag $(prefix)/$(name):$(tag) $(prefix)/$(name):latest 

start:
	docker run -d -p 80:80 -p 443:443 --name $(name) $(prefix)/$(name):latest

stop:
	docker stop $(name)

rm: stop
	docker rm $(name)


clean-docker: clean-docker-latest
	docker rmi $(prefix)/$(name):$(tag)

clean-docker-latest:
	docker rmi $(prefix)/$(name):latest

clean: clean-docker clean-old-images


# vim: ft=make
