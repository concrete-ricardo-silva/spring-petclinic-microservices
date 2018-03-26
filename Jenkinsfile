node {
  checkout scm
  stage 'Build APPs'
  stage 'Pus Images'
  sh 'docker login -u _json_key -p "$(cat /var/jenkins_home/auth.json )" https://gcr.io'
  sh 'for image in $(docker images | grep pet | cut -f1); do docker push $image:latest; done'
}
