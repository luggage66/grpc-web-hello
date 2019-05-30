// import { hello } from 'hello-type-lib'
import * as grpcWeb from 'grpc-web';
import { HelloReply, HelloRequest} from './generated/hello-world_pb'

import { GreeterClient } from './greeterClient';


// display some ouput so we know we reached the front end
const span = window.document.createElement('span');
span.textContent = "hello-frontend: Open the development console.";
window.document.body.appendChild(span);

const resultElement = document.createElement('pre');
document.body.appendChild(resultElement);
resultElement.textContent = "Pending...";


// BEGIN grc-web test

var client = new GreeterClient('http://istio-ingressgateway.istio-system.svc.cluster.local:80', {}, {});

var request = new HelloRequest();
request.setName('FrontEnd');

client.sayHello(request, { }, (err, response) => {
  if (err) {
    console.error(err);
    resultElement.textContent = JSON.stringify(err, null, 2);
  }
  else {
    const resultJsonBlob = JSON.stringify(response.toObject(), null, 2);
    console.log('Success: ', resultJsonBlob);
    resultElement.textContent = resultJsonBlob;
  }
});
