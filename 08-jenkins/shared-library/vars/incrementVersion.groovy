def call() {
    sh 'npm version minor'
    def packageJSON = readJSON file: 'package.json'
    def packageJSONVersion = packageJSON.version
    env.IMAGE_VERSION = "$packageJSONVersion-$BUILD_NUMBER"
}
