import express from 'express';
import { hello } from 'hello-type-lib';
import * as grpc from 'grpc';


const app = express()
const port = 3000

new grpc.Server()

app.get('/', (req, res) => res.send('Hello World!'))

app.listen(port, () => console.log(`Example app listening on port ${port}!`))

class GreeterService extends hello.grpc.Greeter  {
  sayHello(request: hello.grpc.IHelloRequest, callback: hello.grpc.Greeter.SayHelloCallback): void;
  sayHello(request: hello.grpc.IHelloRequest, callback?: hello.grpc.Greeter.SayHelloCallback): Promise<hello.grpc.HelloReply>;
  sayHello(request: hello.grpc.IHelloRequest, callback?: hello.grpc.Greeter.SayHelloCallback): Promise<hello.grpc.HelloReply> | void {
    const reply = hello.grpc.HelloReply.fromObject({ message: "howdy" })

    if (callback) callback(null, reply);
    Promise.resolve(reply)  ;
  }
}


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

GreeterServiceDescription.sayHello = new Proxy(GreeterServiceDescription.sayHello, {
  get(target, propKey, receiver) {
    console.log('GreeterServiceDescription[' + propKey.toString() + ']: ');
    return (<any>target)[propKey];
  }
});



export function createGrpcServer(
): grpc.Server {
  const server = new grpc.Server()

  server.addService(GreeterServiceDescription, {
    sayHello(input: hello.grpc.HelloRequest, callback: any) {
      console.error("ARGS:", arguments);
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
