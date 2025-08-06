import paramiko
from os import environ as env

HOST = env.get('HOST')
PORT = env.get('PORT')
USERNAME = env.get('USERNAME')
PRIVATE_SSH_KEY = env.get('PRIVATE_SSH_KEY')
DOCKER_IMAGE = env.get('DOCKER_IMAGE')
ECR_REGISTRY = env.get('ECR_REGISTRY')
ECR_USR = env.get('ECR_USR')
ECR_PWD = env.get('ECR_PWD')

with paramiko.SSHClient() as ssh_client:
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_client.connect(hostname=HOST, username=USERNAME, key_filename=PRIVATE_SSH_KEY)

    print("Logging in to ECR...")
    stdin, stdout, stderr = ssh_client.exec_command(f"echo {ECR_PWD} | docker login {ECR_REGISTRY} --username {ECR_USR} --password-stdin")
    print("Output:")
    print(stdout.readlines())
    print("Errors:")
    print(stderr.readlines())

    print("Deploying image...")
    stdin, stdout, stderr = ssh_client.exec_command(
        f"""sudo docker stop app
            && sudo docker rm app
            && sudo docker run -d --name app -p {PORT}:{PORT} {DOCKER_IMAGE}"""
        .replace("\n", " ")
    )
    print("Output:")
    print(stdout.readlines())
    print("Errors:")
    print(stderr.readlines())
