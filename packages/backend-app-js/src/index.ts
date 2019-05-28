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


export function createGrpcServer(
  port: number | string = 50066
): grpc.Server {
  const server = new grpc.Server()
  server.addService(hello.grpc.Greeter, {

  })

  server.bind(`0.0.0.0:${port}`, grpc.ServerCredentials.createInsecure())

    // tslint:disable-next-line:no-console
    console.info("Starting gRPC service on port %d", port)

    return server;

}

createGrpcServer();
