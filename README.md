```sh
minikube delete && minikube start
terraform import kubernetes_service_account.default default/default
terraform apply
kubectl delete deploy foo
kubectl run foo --image=gcr.io/$(terraform output project_id)/hello-world
kubectl describe pod foo
git status
```


```sh
lerna bootstrap
lerna run build
cd packages/backend-app-js
yarn start
```

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
# build docker images
docker build . -t hello-grpc-server -f backend.Dockerfile
docker build . -t hello-grpc-client -f frontend.Dockerfile

# apply all k8s configs
find k8s/default -type f | xargs -I {} kubectl apply --namespace default -f {}
find k8s/istio-system -type f | xargs -I {} kubectl apply --namespace istio-system -f {}
```

Undeploy all

```sh
find k8s/default -type f | xargs -I {} kubectl delete --namespace default -f {}
find k8s/istio-system -type f | xargs -I {} kubectl delete --namespace istio-system -f {}
```

```sh
istioctl proxy-config listeners hello-backend-d77647989-6bqfb --port 50066 -o json
```
