def label = "docker-${UUID.randomUUID().toString()}"

podTemplate(label: label, yaml: """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: docker:1.11
    command: ['cat']
    tty: true
    volumeMounts:
    - name: dockersock
      mountPath: /var/run/docker.sock
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
"""
  ) {
    checkout scm

    sh "git rev-parse --short HEAD > commit-id"
    TAG = readFile('commit-id').replace("\n", "").replace("\r", "")
    
    APP_NAME = "hello-kenzan"
    //REGISTRY_HOST = "viable-zebra-docker-registry.registry.svc.cluster.local"
    REGISTRY_HOST_IP = "10.3.243.107"
    REGISTRY_URL = "${REGISTRY_HOST_IP}:5000"
    IMAGE = "${REGISTRY_URL}/${APP_NAME}:${TAG}"
    
    node(label) {
        stage('Build and Push docker image') {
            //git 'https://github.com/Aaquiff/demo-kube-cd-app'

            container('docker') {
                def customImage = docker.build("${image}")
                customImage.push()
            }
        }
    }
}
