```sh
lerna bootstrap
lerna run build
cd packages/backend-app-js
yarn start
```

```sh
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
