FROM node:8-alpine as base

RUN apk add bash

FROM base

WORKDIR /hello-grc-web

COPY . .

RUN npx lerna bootstrap
RUN npx lerna run build

ENTRYPOINT [ "node", "/hello-grc-web/packages/backend-app-js/lib/index" ]
