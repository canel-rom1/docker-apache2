prefix ?= canelrom1
name   ?= apache2
tag    ?= $(shell date +%Y%m%d.%H%M%S)

port   ?= 80

all: run

run:
	docker run -d --name $(name) \
                   -p $(port):80 $(prefix)/$(name):latest

build: Dockerfile
	docker build -t $(prefix)/$(name):$(tag) .
	docker tag $(prefix)/$(name):$(tag) $(prefix)/$(name):latest 

rm:
	docker stop $(name)
	docker rm $(name)

clean-docker:
	docker rmi $(prefix)/$(name):$(tag)

clean-docker-latest:
	docker rmi $(prefix)/$(name):latest

clean: clean-docker clean-docker-latest

monitor:
	docker exec -it $(name) bash


# vim: ft=make
