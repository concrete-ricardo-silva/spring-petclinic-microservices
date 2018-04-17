node {
  checkout scm
  stage 'Build APPs'
    sh("export DOCKER_HOST=unix:///var/run/docker.sock & mvn clean install -PbuildDocker -DskipTests -DREPO=${env.REPO} -DBUILD_NUMBER=${env.BUILD_NUMBER} -DDOCKER_GOOGLE_CREDENTIALS=${env.DOCKER_GOOGLE_CREDENTIALS}")
  stage 'Push Images'
    //sh 'export BUILD_NUMBER && bash ./k8s/api/push.sh'
  stage 'Deploy '
    //sh 'export BUILD_NUMBER && bash ./k8s/api/blue_green.sh'
}
