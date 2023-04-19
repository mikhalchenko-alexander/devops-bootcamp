#!/bin/bash

if ! docker --version &> /dev/null
then
    echo "Installing docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
fi

docker --version

