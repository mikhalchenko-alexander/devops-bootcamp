def call(String repo) {
    withCredentials([usernamePassword(credentialsId: 'github', usernameVariable: 'GITHUB_USER', passwordVariable: 'GITHUB_PASSWORD')]) {
        sh 'git config --global user.name "jenkins"'
        sh 'git config --global user.email "jenkins@example.com"'
        sh "git remote set-url origin https://${GITHUB_USER}:${GITHUB_PASSWORD}@$repo"
        sh "git add ."
        sh 'git commit -m "ci: version bump"'
        sh 'git push origin HEAD:main'
    }
}
