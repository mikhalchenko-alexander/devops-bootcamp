### Access Grafana local instance:

    export POD_NAME=$(kubectl -n monitoring get pod -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=prometheus" -oname)
    kubectl -n monitoring port-forward $POD_NAME 3000

### Get your grafana admin user password by running:

    kubectl get -n monitoring secret -l app.kubernetes.io/component=admin-secret -o jsonpath="{.items[0].data.admin-password}" | base64 --decode ; echo
