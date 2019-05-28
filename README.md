```sh
lerna bootstrap
lerna run build
cd packages/backend-app-js
yarn start
```

```sh
cd packages/hello-type-lib
prototool grpc --address localhost:50066 --method hello.grpc.Greeter/SayHello --data '{ "name": "gfgfd" }'
```
