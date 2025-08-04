from time import sleep

import boto3
import paramiko
import requests
import schedule

session = boto3.Session(profile_name='alex-admin')
ec2_client = session.client('ec2')


def create_instance():
    resp = ec2_client.run_instances(
        ImageId='ami-02003f9f0fde924ea',
        InstanceType='t2.micro',
        KeyName='devops-bootcamp',
        MaxCount=1,
        MinCount=1,
        TagSpecifications=[
            {
                'ResourceType': 'instance',
                'Tags': [
                    {
                        'Key': 'Name',
                        'Value': 'DevOps Automation with Python'
                    }
                ]
            }
        ]
    )

    return resp['Instances'][0]


def get_instance():
    resp = ec2_client.describe_instances(Filters=[{'Name': 'tag:Name', 'Values': ['DevOps Automation with Python']}])
    return resp['Reservations'][0]['Instances'][0]


def instance_ready(inst_id):
    statuses = ec2_client.describe_instance_status(
        InstanceIds=[
            inst_id
        ],
        IncludeAllInstances=True
    )

    for status in statuses['InstanceStatuses']:
        ins_status = status['InstanceStatus']['Status']
        sys_status = status['SystemStatus']['Status']
        state = status['InstanceState']['Name']

        if ins_status == 'ok' and sys_status == 'ok' and state == 'running':
            print(f"Instance {inst_id} is up and running")
            return True
        else:
            print(f"Instance {inst_id} is not up and running yet")
            return False

    print(f"Instance {inst_id} does not exist")
    return False


def initialize_nginx(ip_address):
    with paramiko.SSHClient() as ssh_client:
        ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_client.connect(hostname=ip_address, username='ubuntu',
                       key_filename='/Users/aam/.ssh/devops-bootcamp.pem')
    stdin, stdout, stderr = ssh_client.exec_command(
        """sudo apt-get update
            && sudo apt-get upgrade -y
            && curl -fsSL https://get.docker.com -o get-docker.sh
            && sudo sh ./get-docker.sh
            && sudo docker run -d --name devops-nginx -p 8080:80 nginx:latest""".replace("\n", " "))
    print("Output:")
    print(stdout.readlines())
    print("Errors:")
    print(stderr.readlines())


def restart_nginx(ip_address):
    with paramiko.SSHClient() as ssh_client:
        ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh_client.connect(hostname=ip_address, username='ubuntu',
                           key_filename='/Users/aam/.ssh/devops-bootcamp.pem')
        stdin, stdout, stderr = ssh_client.exec_command("sudo docker restart devops-nginx")
        print("Output:")
        print(stdout.readlines())
        print("Errors:")
        print(stderr.readlines())
        print("Nginx restarted")


def check_instance_health(ip_address):
    print("Checking instance health...")
    try:
        resp = requests.get(f"http://{ip_address}:8080")
        if resp.status_code != 200:
            print(f"Nginx {instance_id} is not healthy. Restarting it...")
            restart_nginx(ip_address)
        else:
            print(f"Nginx {instance_id} is healthy")
    except requests.exceptions.ConnectionError:
        print(f"Nginx {instance_id} is not healthy. Restarting it...")
        restart_nginx(ip_address)


def open_ports(sg_id):
    ec2_client.authorize_security_group_ingress(
        GroupId=sg_id,
        FromPort=22,
        ToPort=22,
        IpProtocol='tcp',
        CidrIp='0.0.0.0/0'
    )

    ec2_client.authorize_security_group_ingress(
        GroupId=sg_id,
        FromPort=8080,
        ToPort=8080,
        IpProtocol='tcp',
        CidrIp='0.0.0.0/0'
    )


def cleanup_instance():
    resp = ec2_client.describe_instances(Filters=[{'Name': 'tag:Name', 'Values': ['DevOps Automation with Python']}])
    inst = resp['Reservations'][0]['Instances'][0]
    inst_id = inst['InstanceId']

    ec2_client.terminate_instances(InstanceIds=[instance_id])
    print(f"Instance {inst_id} terminated")

    ec2_client.revoke_security_group_ingress(
        GroupId=security_group_id,
        FromPort=22,
        ToPort=22,
        IpProtocol='tcp',
        CidrIp='0.0.0.0/0'
    )

    ec2_client.revoke_security_group_ingress(
        GroupId=security_group_id,
        FromPort=8080,
        ToPort=8080,
        IpProtocol='tcp',
        CidrIp='0.0.0.0/0'
    )


existing_instance = get_instance()
if existing_instance:
    instance = existing_instance
    print(f"Instance retrieved")
else:
    instance = create_instance()
    print(f"Instance created")

instance_id = instance['InstanceId']
print(f"Instance ID: {instance_id}")

while not instance_ready(instance_id):
    sleep(10)

initialized_instance = ec2_client.describe_instances(InstanceIds=[instance_id])['Reservations'][0]['Instances'][0]
public_ip_address = initialized_instance['PublicIpAddress']
security_group_id = initialized_instance['SecurityGroups'][0]['GroupId']
print(f"Public IP address: {public_ip_address}, Security Group ID: {security_group_id}")

open_ports(security_group_id)
initialize_nginx(public_ip_address)

schedule.every(10).seconds.do(check_instance_health, public_ip_address)

while True:
    schedule.run_pending()
