VPC_ID=$(aws ec2 create-vpc --query Vpc.VpcId --cidr-block 10.0.0.0/16 --output text --tag-specifications "ResourceType=vpc,Tags=[{Key='Name',Value='node-app-vpc'}]")
SUBNET_ID=$(aws ec2 create-subnet --vpc-id=$VPC_ID --cidr-block 10.0.1.0/24 --tag-specifications "ResourceType=subnet,Tags=[{Key='Name',Value='node-app-subnet'}]" --query Subnet.SubnetId --output text)
SG_ID=$(aws ec2 create-security-group --group-name node-app-sg --vpc-id $VPC_ID --description "Node app SG" --query GroupId --output text --tag-specifications "ResourceType=security-group,Tags=[{Key='Name',Value='node-app-sg'}]")
aws ec2 authorize-security-group-ingress --port 22 --protocol tcp --cidr 0.0.0.0/0 --group-id $SG_ID
IGW_ID=$(aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text)
aws ec2 attach-internet-gateway --vpc-id $VPC_ID --internet-gateway-id $IGW_ID
RTB_ID=$(aws ec2 create-route-table --vpc-id $VPC_ID --query RouteTable.RouteTableId --output text)
aws ec2 create-route --route-table-id $RTB_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID
aws ec2 associate-route-table --route-table-id $RTB_ID --subnet-id $SUBNET_ID
