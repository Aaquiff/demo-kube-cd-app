node {

    checkout scm

    env.DOCKER_API_VERSION="1.23"
    
    sh "git rev-parse --short HEAD > commit-id"
    TAG = readFile('commit-id').replace("\n", "").replace("\r", "")
    
    HOST = env.REGISTRY_SERVICE_HOST
    PORT = env.REGISTRY_SERVICE_PORT
    REGISTRY_URL = "127.0.0.1:30500"
    APP_NAME = "hello-kenzan"
    IMAGE_NAME = "${REGISTRY_URL}/${APP_NAME}:${TAG}"
      
    stage "docker build"
        sh """
        docker run -d -e 'REG_IP=${HOST}' -e 'REG_PORT=${PORT}' --name socat-registry -p 30500:5000 aaquiff/socat:1.0
        
        docker build -t ${IMAGE_NAME} .
        docker push ${IMAGE_NAME}
        
        docker stop socat-registry; docker rm socat-registry
        """
    stage "deploy k8s"
        
        sh """
        sed 's|<IMAGE_NAME>|${IMAGE_NAME}|' -i k8s/deployment.yaml
        kubectl apply -f k8s/deployment.yaml
        """
}