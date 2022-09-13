#!/bin/bash

NEW_USER=myapp


echo "Updating package ropositories"
sudo apt update

echo "Installing packages"
sudo apt install nodejs npm -y

node_version=$(node --version)
npm_version=$(npm --version)

echo "NodeJS version $node_version installed"
echo "NPM version $npm_version installed"

sudo useradd $NEW_USER -m

echo "Downloading application"
sudo runuser -l $NEW_USER -c "wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"

echo "Unzipping application"
sudo runuser -l $NEW_USER -c "tar zxvf bootcamp-node-envvars-project-1.0.0.tgz"

echo -n "Set log directory location for the application (absolute path): "
read LOG_DIRECTORY

if [ -d $LOG_DIRECTORY ]
then
	echo "Log directory already exists"
else
	sudo mkdir -p $LOG_DIRECTORY
	sudo chown $NEW_USER -R $LOG_DIRECTORY
	echo "Log directory $LOG_DIRECTORY created"
fi

sudo runuser -l $NEW_USER -c "
	export APP_ENV=dev
	export DB_USER=myuser
	export DB_PWD=mysecret
	export LOG_DIR=$LOG_DIRECTORY
	cd package &&
	npm install &&
	node server.js &
"

sleep 5

ps aux | grep node | grep -v grep
sudo netstat -ntlp | grep :3000 

