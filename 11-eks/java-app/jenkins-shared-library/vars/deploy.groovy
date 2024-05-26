def call(String clusterName, String region) {
    withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
        sh "aws eks update-kubeconfig --name $clusterName --region $region"

        String kubeconfigPath = '/root/.kube/config'

        dir('11-eks/mysql') {
            sh "helm upgrade --kubeconfig $kubeconfigPath mysql oci://registry-1.docker.io/bitnamicharts/mysql -f mysql-values.yaml"
        }

        dir('11-eks/phpmyadmin') {
            sh "helm upgrade --kubeconfig $kubeconfigPath phpmyadmin oci://registry-1.docker.io/bitnamicharts/phpmyadmin"
        }

        dir('11-eks/java-app') {
            sh "helm upgrade --kubeconfig $kubeconfigPath -n java-app java-app java-app-helm-chart"
        }
    }
}
