build-js:
	lerna run build

build-docker:
	docker build . -t hello-grpc-server -f backend.Dockerfile
	docker build . -t hello-grpc-client -f frontend.Dockerfile

build:
build: build-js build-docker

deploy:
	find k8s/default -type f | xargs -I {} kubectl apply --namespace default -f {}
	find k8s/istio-system -type f | xargs -I {} kubectl apply --namespace istio-system -f {}

undeploy:
	find k8s/default -type f | xargs -I {} kubectl delete --namespace default -f {}
	find k8s/istio-system -type f | xargs -I {} kubectl delete --namespace istio-system -f {}
