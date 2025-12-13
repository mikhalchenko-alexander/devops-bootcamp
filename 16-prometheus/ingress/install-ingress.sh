helm install nginx-ingress ingress-nginx/ingress-nginx -f override.yaml
sleep 10
kubectl apply -f ingress.yaml
