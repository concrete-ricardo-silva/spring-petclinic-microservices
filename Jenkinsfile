node {
  checkout scm
  stage 'Build APPs'
  stage 'Push Images'
  stage 'Deploy'
    sh './spring-petclinic-microservices/k8s/api/deploy.sh'
  
}
