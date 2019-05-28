import * as grpcWeb from 'grpc-web';

import {
  HelloReply,
  HelloRequest} from '../lib/hello-world_pb';

export class GreeterClient {
  client_: grpcWeb.AbstractClientBase;
  hostname_: string;
  credentials_: null | { [index: string]: string; };
  options_: null | { [index: string]: string; };

  constructor (hostname: string,
               credentials: null | { [index: string]: string; },
               options: null | { [index: string]: string; }) {
    if (!options) options = {};
    options['format'] = 'text';

    this.client_ = new grpcWeb.GrpcWebClientBase(options);
    this.hostname_ = hostname;
    this.credentials_ = credentials;
    this.options_ = options;
  }

  methodInfoSayHello = new grpcWeb.AbstractClientBase.MethodInfo(
    HelloReply,
    (request: HelloRequest) => {
      return request.serializeBinary();
    },
    <any>HelloReply.deserializeBinary
  );

  sayHello(
    request: HelloRequest,
    metadata: grpcWeb.Metadata | null,
    callback: (err: grpcWeb.Error,
               response: HelloReply) => void) {
    return this.client_.rpcCall(
      this.hostname_ +
        '/hello.grpc.Greeter/SayHello',
      request,
      metadata || {},
      this.methodInfoSayHello,
      callback);
  }

}

