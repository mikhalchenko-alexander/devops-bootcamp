aws ec2 describe-subnets --filters "Name=tag:Name,Values=node-app-subnet" --query Subnets[0].SubnetId --output text
