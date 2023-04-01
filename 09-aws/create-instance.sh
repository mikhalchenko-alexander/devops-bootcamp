aws ec2 create-key-pair --key-name alex-key --key-type rsa --key-format pem --tag-specifications "ResourceType=key-pair,Tags=[{Key='Name',Value='node-app-key-pair'}]" --query "KeyMaterial" --output text > ~/.ssh/node-app.pem
chmod 400 ~/.ssh/node-app.pem
