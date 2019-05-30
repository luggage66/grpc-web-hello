// import { hello } from 'hello-type-lib'
import * as grpcWeb from 'grpc-web';
import { HelloReply, HelloRequest} from './generated/hello-world_pb'

import { GreeterClient } from './greeterClient';

var client = new GreeterClient('http://istio-ingressgateway.istio-system.svc.cluster.local:80', {}, {
  suppressCorsPreflight: "true"
});

var request = new HelloRequest();
request.setName('World');

client.sayHello(request, { }, (err, response) => {
  console.error(err);
  console.log(response.getMessage());
});

console.log('foo')
