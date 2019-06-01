bootstrap:
	npx lerna bootstrap

build-js:
	lerna run build

build-docker:
	docker build . -t hello-grpc-server -f backend.Dockerfile
	docker build . -t hello-grpc-client -f frontend.Dockerfile

build: build-js build-docker

deploy:
	helm upgrade --install grpc-web-hello helm/grpc-web-hello --namespace grpc-web-hello

undeploy:
	helm delete --purge grpc-web-hello
