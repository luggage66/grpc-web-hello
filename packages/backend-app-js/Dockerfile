FROM node:8

WORKDIR /app

COPY lib ./lib
COPY package.json .

RUN yarn install

ENTRYPOINT [ "node", "lib/index" ]