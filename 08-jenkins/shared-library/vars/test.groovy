def call() {
    sh 'npm ci'
    sh 'npm run test'
}
