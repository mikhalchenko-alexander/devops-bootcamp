def call(String imageName, String dockerHost) {
    withCredentials([usernamePassword(credentialsId: 'nexus', usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASSWORD')]) {
        sh "echo ${NEXUS_PASSWORD} | docker login $dockerHost -u ${NEXUS_USER} --password-stdin"
        sh "docker build -t $imageName ."
        sh "docker push $imageName"
    }
}
