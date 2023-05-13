aws ec2 describe-security-groups --filters "Name=tag:Name,Values=node-app-sg" --query 'SecurityGroups[0].GroupId' --output text
