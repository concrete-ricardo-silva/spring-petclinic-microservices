node {
  checkout scm
  def COLOR = sh script: 'curl https://storage.googleapis.com/state-config/state'
  try {
  stage 'Build APPs'
    sh("export DOCKER_HOST=unix:///var/run/docker.sock & mvn clean install -PbuildDocker -DskipTests -DREPO=${env.REPO} -DBUILD_NUMBER=${env.BUILD_NUMBER}")
  }catch (err) {

        currentBuild.result = "FAILURE"

        throw err
  }
  stage 'Push Images'
    try {
    sh 'bash ./k8s/push.sh'
    }catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }
  
  stage 'Deploy To New Color'
    try {
    sh 'export COLOR=${COLOR} && bash ./k8s/deploy.sh'
    }catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }
  
  stage 'Deploy To Prod'
    try {
    sh 'export COLOR=${COLOR} && bash ./k8s/dns.sh'
  }catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }
  }
