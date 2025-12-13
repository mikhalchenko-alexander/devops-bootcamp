kubectl create namespace monitoring
helm install monitoring-stack oci://ghcr.io/prometheus-community/charts/kube-prometheus-stack -n monitoring
