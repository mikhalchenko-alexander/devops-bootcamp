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

    stdin, stdout, stderr = ssh_client.exec_command("docker ps")
    output = stdout.readlines()
    container_is_running = any("app" in line for line in output)

    if container_is_running:
        print("Stopping existing container...")
        stdin, stdout, stderr = ssh_client.exec_command("sudo docker stop app && sudo docker rm app")
        print("Output:")
        print(stdout.readlines())
        print("Errors:")

    print("Deploying image...")
    stdin, stdout, stderr = ssh_client.exec_command(
        f"sudo docker run -d --name app -p {PORT}:{PORT} {DOCKER_IMAGE}"
    )
    print("Output:")
    print(stdout.readlines())
    print("Errors:")
    print(stderr.readlines())
