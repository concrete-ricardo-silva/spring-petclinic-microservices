node {
  checkout scm
  step 'Build APPs'
  step 'Push Images'
  step 'Deploy'
    sh 'cd .k8s/api/ & kubectl create -f 1-config-server-deployment.yaml'
  
}
