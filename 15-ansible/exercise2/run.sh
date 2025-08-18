#!/bin/bash

JAR_PATH=$1
VERSION=$2

if [ -z "$JAR_PATH" ] || [ -z "$VERSION" ]; then
    echo "Usage: $0 <jar-path> <version>"
    exit 1
fi

ansible-playbook exercise2.yaml -e "@vars.yaml" -e "@secrets.yaml" -e "jar_path=$JAR_PATH" -e "version=$VERSION"
