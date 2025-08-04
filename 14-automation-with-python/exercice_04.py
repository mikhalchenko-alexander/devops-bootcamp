import boto3

session = boto3.Session(profile_name='alex-admin')
ecr_client = session.client('ecr')

response = ecr_client.describe_repositories()
repositories = response['repositories']
for repository in repositories:
    print(repository['repositoryName'])

if len(repositories) > 0:
    repository_name = repositories[0]['repositoryName']
    response = ecr_client.describe_images(repositoryName=repository_name)
    images = response['imageDetails']
    tags = []
    for image in images:
        pushed_at = image['imagePushedAt']
        for tag in image['imageTags']:
            tags.append([pushed_at, tag])
    tags.sort(key=lambda x: x[0], reverse=True)
    print(f"Most recent tags for repository {repository_name}:")
    for tag in tags:
        print(f"  {tag[1]} pushed at {tag[0]}")
else:
    print("No repositories found.")
