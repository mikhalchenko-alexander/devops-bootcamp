import boto3
from os import environ as env

ECR_REGISTRY = env.get('ECR_REGISTRY')
ECR_REPOSITORY = '14-node-js-app'

session = boto3.Session()
ecr_client = session.client('ecr')

response = ecr_client.describe_images(repositoryName=ECR_REPOSITORY)
images = response['imageDetails']
tags = [image['imageTags'][0] for image in images]
tags.sort(key=lambda x: x[0], reverse=True)
for tag in tags:
    print(tag)
