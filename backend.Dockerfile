FROM node:8-alpine as base

RUN apk add bash

FROM base

WORKDIR /hello-grc-web

COPY . .

RUN npm config set unsafe-perm true && \
   npx lerna bootstrap && \
   npm config set unsafe-perm false

RUN npx lerna run build

ENTRYPOINT [ "node", "/hello-grc-web/packages/backend-app-js/lib/index" ]
