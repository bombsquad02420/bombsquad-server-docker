.PHONY: build build tag push

version=1.6.9

build:
	docker build --tag bombsquad-server --build-arg BS_VERSION=$(version) .

tag:
	docker tag bombsquad-server aryan02420/bombsquad-server:latest
	docker tag bombsquad-server aryan02420/bombsquad-server:$(version)

push:
	docker push aryan02420/bombsquad-server:latest
	docker push aryan02420/bombsquad-server:$(version)

