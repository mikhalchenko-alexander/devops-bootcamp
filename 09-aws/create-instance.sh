aws ec2 run-instances \
	--image-id ami-0ec7f9846da6b0f61 \
	--instance-type t2.micro \
	--key-name node-app-key \
	--subnet-id $(./get-subnet-id.sh) \
	--security-group-ids "$(./get-sg-id.sh)" \
	--associate-public-ip-address \
	--tag-specifications "ResourceType=instance,Tags=[{Key='Name',Value='node-app-instance'}]"
