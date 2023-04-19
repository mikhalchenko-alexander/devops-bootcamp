scp -i ~/.ssh/node-app.pem install-docker.sh ubuntu@$(./get-instance-ip.sh):~/
ssh -i ~/.ssh/node-app.pem ubuntu@$(./get-instance-ip.sh) ./install-docker.sh
