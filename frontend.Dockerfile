FROM node:8-alpine as base

RUN apk add bash

FROM base

WORKDIR /hello-grc-web

COPY . .

RUN npm config set unsafe-perm true && \
   npx lerna bootstrap && \
   npm config set unsafe-perm false

RUN npx lerna run build

WORKDIR /hello-grc-web/packages/frontend-app-js

ENTRYPOINT [ "node", "/hello-grc-web/packages/frontend-app-js/node_modules/.bin/webpack-dev-server" ]
