FROM node:19-alpine3.16

RUN apk add shadow && \
    useradd nodejs -m && \
    mkdir /opt/app \

WORKDIR /opt/app

COPY . .

RUN chown -R nodejs:nodejs .

USER nodejs

RUN npm ci

ENTRYPOINT node server.js
