node {
  checkout scm
  stage 'Build APPs'
    
  stage 'Push Images'
    sh 'docker login -u _json_key -p "$(cat /var/jenkins_home/auth.json )" https://gcr.io'
    sh 'for image in $(docker images | grep pet | cut -f1 -d " "); do docker push $image:latest; done
  stage 'Deploy'
    sh 'bash ./k8s/api/deploy.sh'
  
}
