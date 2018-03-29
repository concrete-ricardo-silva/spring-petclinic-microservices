node {
  checkout scm
  stage 'Build APPs'
    //sh("export DOCKER_HOST=unix:///var/run/docker.sock & mvn clean install -PbuildDocker -DskipTests -DREPO=${env.REPO} -DREPO=${env.BUILD_NUMBER} -DDOCKER_GOOGLE_CREDENTIALS=${env.DOCKER_GOOGLE_CREDENTIALS}")
  stage 'Push Images'
    sh 'docker login -u _json_key -p "$(cat /var/jenkins_home/auth.json )" https://gcr.io'
    sh 'export BUILD_NUMBER && for image in $(docker images | grep spring-petclinic | cut -f1 -d " "); do docker push $image:$BUILD_NUMBER; done'
  stage 'Deploy'
    //sh 'bash ./k8s/api/deploy.sh'
    //sh 'export $BUILD_NUMBER && bash ./k8s/api/deploy_update.sh'
  }
