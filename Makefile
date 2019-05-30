bootstrap:
	npx lerna bootstrap

build-js:
	lerna run build

build-docker:
	docker build . -t hello-grpc-server -f backend.Dockerfile
	docker build . -t hello-grpc-client -f frontend.Dockerfile

build:
build: build-js build-docker

deploy:
	find k8s -type f | xargs -I {} kubectl apply --namespace default -f {}

undeploy:
	find k8s -type f | xargs -I {} kubectl delete --namespace default -f {}

cleandeploy:
cleandeploy: undeply deploy
