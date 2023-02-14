FROM node:19-alpine3.16

RUN apk add shadow && \
    useradd nodejs -m && \
    mkdir /opt/app && \
    chown -R nodejs:nodejs /opt/app

USER nodejs

WORKDIR /opt/app

COPY . .

RUN npm ci

ENTRYPOINT node server.js

