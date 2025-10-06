eksctl create cluster -f cluster.yml
aws eks update-kubeconfig --region eu-central-1 --name devops-bootcamp
kubectl create namespace java-app
kubectl apply -f storage-class.yaml
