export IMAGE_NAME=$1
docker compose -f docker-compose.yml up -d
echo 'Success'
