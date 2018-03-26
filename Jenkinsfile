node {
  checkout scm
  stage 'Build image'
  sh("export DOCKER_HOST=unix:///var/run/docker.sock & mvn clean install -PbuildDocker -DREPO=${env.REPO} -DDOCKER_GOOGLE_CREDENTIALS=${env.DOCKER_GOOGLE_CREDENTIALS}")
  }
