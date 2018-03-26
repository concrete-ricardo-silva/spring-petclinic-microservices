node {
  checkout scm
  stage 'Build APPs'
  stage 'Push images'
  sh("export DOCKER_HOST=unix:///var/run/docker.sock & mvn -Ppush-image -DskipTests -DREPO=${env.REPO} -DDOCKER_GOOGLE_CREDENTIALS=${env.DOCKER_GOOGLE_CREDENTIALS}")  
}
