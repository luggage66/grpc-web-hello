FROM node:8 as base

RUN npm install -g lerna

FROM base

WORKDIR /hello-grc-web

COPY . .

RUN lerna bootstrap
RUN lerna run build

WORKDIR /hello-grc-web/packages/frontend-app-js

ENTRYPOINT [ "node", "/hello-grc-web/packages/frontend-app-js/node_modules/.bin/webpack-dev-server" ]
