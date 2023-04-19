aws ec2 describe-instances --filters "Name=tag:Name,Values=node-app-instance" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].PublicIpAddress" --output text
