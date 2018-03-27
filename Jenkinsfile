node {
  checkout scm
  stage 'Build APPs'
  stage 'Push Images'
  stage 'Deploy'
    sh 'bash ./k8s/api/deploy.sh'
  
}
