import boto3

session = boto3.Session(profile_name='alex-admin')
ec2_client = session.client('ec2')
vpcs = ec2_client.describe_vpcs()
for vpc in vpcs['Vpcs']:
    vpc_id = vpc['VpcId']
    subnets = ec2_client.describe_subnets(Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])
    for subnet in subnets['Subnets']:
        print(subnet['SubnetId'])
