import express from 'express';
import { hello } from 'hello-type-lib';
import * as grpc from 'grpc';

// Just so I know this service is reachable
const app = express()
const port = 3000
app.get('/backend-health', (req, res) => res.send('Backend is here.'))
app.listen(port, () => console.log(`Example app listening on port ${port}!`))

// wire protobufjs generated messages types to grpc-node
const GreeterServiceDescription = {
  // Sends a greeting
  sayHello: {
    path: '/hello.grpc.Greeter/SayHello',
    requestStream: false,
    responseStream: false,
    requestType: hello.grpc.HelloRequest,
    responseType: hello.grpc.HelloReply,
    requestSerialize: (data: hello.grpc.HelloRequest) => Buffer.from(hello.grpc.HelloRequest.encode(data).finish()),
    requestDeserialize: (buffer: Buffer) => {
      console.log('requestDeserialize');
      return hello.grpc.HelloRequest.decode(buffer);
    },
    responseSerialize: (data: hello.grpc.HelloReply) => Buffer.from(hello.grpc.HelloReply.encode(data).finish()),
    responseDeserialize: (buffer: Buffer) => hello.grpc.HelloReply.decode(buffer)
  },
};

function createGrpcServer(): grpc.Server {
  const server = new grpc.Server()

  server.addService(GreeterServiceDescription, {
    sayHello(input: grpc.ServerUnaryCall<hello.grpc.HelloRequest>, callback: grpc.sendUnaryData<hello.grpc.HelloReply>) {
      console.log("ARGS:", arguments);
      callback(null, hello.grpc.HelloReply.fromObject({ message: "hello " + input.request.name}))
    }
  })

  const port = 50066;

  server.bind(`0.0.0.0:${port}`, grpc.ServerCredentials.createInsecure())

  // tslint:disable-next-line:no-console
  console.info("Starting gRPC service on port %d", port)

  return server;
}

const myServer = createGrpcServer();
myServer.start();
