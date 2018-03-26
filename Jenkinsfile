node {
  checkout scm
  stage 'Build APPs'
  sh("export DOCKER_HOST=unix:///var/run/docker.sock & mvn clean install -PbuildDocker -DskipTests -DREPO=${env.REPO} -DDOCKER_GOOGLE_CREDENTIALS=${env.DOCKER_GOOGLE_CREDENTIALS}")
  stage 'Pus Images'
  sh 'docker login -u _json_key -p "$(cat /var/jenkins_home/auth.json )" https://gcr.io'
  sh 'for image in $(docker images | grep pet | awk '{print $1}'); do docker push $image:latest; done'
}
