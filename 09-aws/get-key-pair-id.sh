aws ec2 describe-key-pairs  --filters "Name=tag:Name,Values=node-app-key-pair" --query KeyPairs[0].KeyPairId --output text
