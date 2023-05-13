export IMAGE_NAME=$1
docker compose up -f docker-compose.yaml -d
echo 'Success'
