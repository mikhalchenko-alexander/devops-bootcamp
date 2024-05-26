def call(String clusterName, String region) {
    withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
        sh "aws eks update-kubeconfig --name $clusterName --region $region"

        String kubeconfigPath = '/root/.kube/config'

        sh "kubectl get nodes"

        dir('11-eks/mysql') {
            sh "helm upgrade mysql oci://registry-1.docker.io/bitnamicharts/mysql -f mysql-values.yaml --kubeconfig $kubeconfigPath --debug"
        }

        dir('11-eks/phpmyadmin') {
            sh "helm upgrade phpmyadmin oci://registry-1.docker.io/bitnamicharts/phpmyadmin --kubeconfig $kubeconfigPath --debug"
        }

        dir('11-eks/java-app') {
            sh "helm upgrade -n java-app java-app java-app-helm-chart --kubeconfig $kubeconfigPath --debug"
        }
    }
}
