export IMAGE_NAME=$1
echo $3 | docker login docker.io -u $2 --password-stdin
docker compose -f docker-compose.yml up -d
echo 'Success'
