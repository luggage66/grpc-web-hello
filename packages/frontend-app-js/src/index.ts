// import { hello } from 'hello-type-lib'
import * as grpcWeb from 'grpc-web';
import { HelloReply, HelloRequest} from './generated/hello-world_pb'

import { GreeterClient } from './greeterClient';

var client = new GreeterClient('http://192.168.99.118:31215', {}, {});

var request = new HelloRequest();
request.setName('World');

client.sayHello(request, {}, (err, response) => {
  console.log(response.getMessage());
});

console.log('foo')
