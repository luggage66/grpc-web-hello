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
protoc -I../hello-type-lib/proto ../hello-type-lib/proto/hello-world.proto --js_out=import_style=typescript:lib --grpc-web_out=import_style=typescript,mode=grpcwebtext:lib

cd packages/hello-type-lib

prototool grpc --address localhost:50066 --method hello.grpc.Greeter/SayHello --data '{ "name": "gfgfd" }'

# or
prototool grpc --address $(minikube service hello-backend --url --format "{{.IP}}:{{.Port}} | head -n 1") --method hello.grpc.Greeter/SayHello --data '{ "name": "gfgfd" }'

```

```sh
docker build . -t hello-grpc-server -f backend.Dockerfile
kubectl run hello-backend --image=hello-grpc-server --image-pull-policy Never

kubectl apply -f backend_deployment.yaml
kubectl apply -f backend_service.yaml
```
