#!/bin/bash


if [[ -z "$1" || -z "$2" ]]
then
    echo No repository or tag specified.
    echo Example usage ./push-app-docker-image.sh my.repo.com 1.0
    exit 1
fi

echo Publishing image $1/app:$2

./gradlew build
docker build -t $1/app:$2 .
docker push $1/app:$2

