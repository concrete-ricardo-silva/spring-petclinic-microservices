node {
  checkout scm
  stage 'Build APPs'
  stage 'Push Images'
  stage 'Deploy'
    sh './k8s/api/deploy.sh'
  
}
