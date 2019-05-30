setup and run

```sh
make build-js
make build-docker

make deploy
```

To run local client:

```sh
cd packages/frontend-app-js
webpack-dev-server
```

To run local backend:

```sh
cd packages/backend-app-js
yarn start
```

Undeploy all

```sh
find k8s/default -type f | xargs -I {} kubectl delete --namespace default -f {}
find k8s/istio-system -type f | xargs -I {} kubectl delete --namespace istio-system -f {}
```

Random stuff:

```sh
cd packages/frontend-app-js
mkdir -p src/generated
protoc -I../hello-type-lib/proto ../hello-type-lib/proto/hello-world.proto --js_out=import_style=typescript:src/generated --grpc-web_out=import_style=typescript,mode=grpcwebtext:src/generated

cd packages/hello-type-lib

prototool grpc --address localhost:50066 --method hello.grpc.Greeter/SayHello --data '{ "name": "gfgfd" }'

# or
prototool grpc --address $(minikube service hello-backend --url --format "{{.IP}}:{{.Port}}" | head -n 1) --method hello.grpc.Greeter/SayHello --data '{ "name": "gfgfd" }'
```

```sh
istioctl proxy-config listeners hello-backend-d77647989-6bqfb --port 50066 -o json
```

```sh
minikube delete && minikube start
terraform import kubernetes_service_account.default default/default
terraform apply
kubectl delete deploy foo
kubectl run foo --image=gcr.io/$(terraform output project_id)/hello-world
kubectl describe pod foo
git status
```


https://github.com/istio/istio/pull/10064
