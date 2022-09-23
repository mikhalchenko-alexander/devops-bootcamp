#!/bin/bash

NEW_USER=myapp



echo "Updating package ropositories"
sudo apt update

echo "Installing packages"
sudo apt install net-tools nodejs npm -y

node_version=$(node --version)
npm_version=$(npm --version)

echo "NodeJS version $node_version installed"
echo "NPM version $npm_version installed"

sudo useradd $NEW_USER -m

echo "Unzipping application"
cp bootcamp-node-project-1.0.0.tgz /home/$NEW_USER
sudo runuser -l $NEW_USER -c "tar zxvf bootcamp-node-project-1.0.0.tgz"

sudo runuser -l $NEW_USER -c "
	cd package &&
	npm i &&	
	node server.js &
"

sleep 5

ps aux | grep node | grep -v grep
sudo netstat -ntlp | grep :3000 

