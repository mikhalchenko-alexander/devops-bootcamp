def call(String clusterName, String region) {
    withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
        sh "aws eks update-kubeconfig --name $clusterName --region $region"
        sh 'helm install -n java-app java-app java-app-helm-chart'
    }
}
