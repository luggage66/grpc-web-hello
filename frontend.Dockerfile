FROM node:8-alpine as base

RUN apk add bash

FROM base

WORKDIR /hello-grc-web

COPY . .

RUN npx lerna bootstrap
RUN npx lerna run build

WORKDIR /hello-grc-web/packages/frontend-app-js

ENTRYPOINT [ "node", "/hello-grc-web/packages/frontend-app-js/node_modules/.bin/webpack-dev-server" ]
