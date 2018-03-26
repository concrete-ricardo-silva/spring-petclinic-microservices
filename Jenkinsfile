node {
  checkout scm
  stage 'Build image'
  sh("export DOCKER_HOST=unix:///var/run/docker.sock & mvn clean install -PbuildDocker ${env.MAVEN_OPTS}")
  }
