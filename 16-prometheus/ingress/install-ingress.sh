helm install nginx-ingress ingress-nginx/ingress-nginx
sleep 10
kubectl apply -f ingress.yaml
