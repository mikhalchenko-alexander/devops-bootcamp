#!/bin/bash

docker run \
    -e MYSQL_USER=app \
    -e MYSQL_PASSWORD=secret \
    -e MYSQL_DATABASE=app \
    -e MYSQL_ROOT_PASSWORD=supersecret \
    -p 3306:3306 \
    --name app-mysql \
    mysql:8

