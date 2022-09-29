#!/bin/bash

NODE_USER="nodejs"
NODE_APP_DIR="/home/$NODE_USER/nodeapp"

apt update
apt install -y jq nodejs npm

echo -n 'Username:'

read USER

echo -n 'Password:'

read -s PASS

curl -u $USER:$PASS -X GET 'http://167.99.244.109:8081/service/rest/v1/components?repository=project1-npm&sort=version' | jq "." > artifact.json
artifactDownloadUrl=$(jq '.items[].assets[].downloadUrl' artifact.json --raw-output)
wget --http-user=$USER --http-password=$PASS $artifactDownloadUrl

useradd $NODE_USER -m

mkdir -p $NODE_APP_DIR
tar -xf bootcamp-node-project-1.0.0.tgz --directory /home/$NODE_USER/nodeapp
chown -R $NODE_USER:$NODE_USER $NODE_APP_DIR

runuser -l $NODE_USER -c "cd $NODE_APP_DIR/package &&
	npm install &&
	node server.js &"

