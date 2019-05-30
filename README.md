after clone:
from: https://github.com/grpc/grpc-web

```sh
curl -O https://github.com/grpc/grpc-web/releases/download/1.0.4/protoc-gen-grpc-web-1.0.4-darwin-x86_64
sudo mv protoc-gen-grpc-web-1.0.4-darwin-x86_64 /usr/local/bin/protoc-gen-grpc-web
chmod +x /usr/local/bin/protoc-gen-grpc-web
```

setup and run

```sh
eval $(minikube docker-env)
make bootstrap
make build-js
make build-docker
make deploy
```

Undeploy all

```sh
make undeploy
```

Using:

```sh
# this should go to the backend:3000 and just return "Backend is here" (works)
curl http://istio-ingressgateway.istio-system.svc.cluster.local/backend-health

# should open your browser to the front end (which goes a grpc-web call, open the console to see)
# the grpc-web call here does not work (503)
open http://istio-ingressgateway.istio-system.svc.cluster.local/

# grpc (works)
cd packages/hello-type-lib
export INGRESS_IP=$(dig +short istio-ingressgateway.istio-system.svc.cluster.local @$(minikube ip) -p 30053)
prototool grpc --address ${INGRESS_IP}:80 --method hello.grpc.Greeter/SayHello --data '{ "name": "jimbo" }'
```


To run local client:

```sh
cd packages/frontend-app-js
webpack-dev-server
```

To run local backend (useless, use the deployed one in minikube):

```sh
cd packages/backend-app-js
yarn start
```

Random stuff / notes:

```sh
cd packages/frontend-app-js
mkdir -p src/generated
protoc -I../hello-type-lib/proto ../hello-type-lib/proto/hello-world.proto --js_out=import_style=typescript:src/generated --grpc-web_out=import_style=typescript,mode=grpcwebtext:src/generated

cd packages/hello-type-lib

prototool grpc --address localhost:50066 --method hello.grpc.Greeter/SayHello --data '{ "name": "gfgfd" }'

# or
export ISTIO_INGRESS_IP=get real IP for istio-ingressgateway.istio-system.svc.cluster.local
prototool grpc --address "${ISTIO_INGRESS_IP}:80" --method hello.grpc.Greeter/SayHello --data '{ "name": "gfgfd" }'
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
