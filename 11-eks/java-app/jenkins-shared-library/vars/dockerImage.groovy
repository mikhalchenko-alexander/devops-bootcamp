def call(String imageName, String dockerHost) {
    withCredentials([usernamePassword(credentialsId: 'ecr', usernameVariable: 'ECR_USER', passwordVariable: 'ECR_PASSWORD')]) {
        sh "echo ${ECR_PASSWORD} | docker login $dockerHost -u ${ECR_USER} --password-stdin"
        sh "docker build --platform linux/amd64/v2 -t $imageName ."
        sh "docker push $imageName"
    }
}
