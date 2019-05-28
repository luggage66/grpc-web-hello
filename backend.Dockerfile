FROM node:8 as base

RUN npm install -g lerna

FROM base

WORKDIR /hello-grc-web

COPY . .

RUN lerna bootstrap
RUN lerna run build

ENTRYPOINT [ "node", "/hello-grc-web/packages/backend-app-js/lib/index" ]
