node {
    stage('Build and Push docker image') {
          git 'https://github.com/Aaquiff/demo-kube-cd-app'

          sh "git rev-parse --short HEAD > commit-id"
          TAG = readFile('commit-id').replace("\n", "").replace("\r", "")

          APP_NAME = "hello-kenzan"
          IMAGE = "${APP_NAME}:${TAG}"
          
          sh """
            docker build -t \$REGISTRY_USERNAME/${IMAGE} ./
            docker push \$REGISTRY_USERNAME/${IMAGE}
          """
    }
}
