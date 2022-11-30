#!/bin/bash

docker run \
    -d \
    --name app-phpmyadmin \
    --link app-mysql:db \
    -p 8081:80 \
    phpmyadmin:5

