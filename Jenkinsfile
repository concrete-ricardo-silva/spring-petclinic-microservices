node {
  checkout scm
  def COLOR = sh script: 'curl https://storage.googleapis.com/state-config/state'
  
  stage 'Build APPs'
    sh("export DOCKER_HOST=unix:///var/run/docker.sock & mvn clean install -PbuildDocker -DskipTests -DREPO=${env.REPO} -DBUILD_NUMBER=${env.BUILD_NUMBER}")
  
  stage 'Push Images'
    sh 'bash ./k8s/push.sh'
  
  stage 'Deploy To New Color'
    sh 'bash ./k8s/deploy.sh'
      waitUntil {
      sh 'echo "petclinic.redligth.com.br"' 
      }
  
  stage 'Deploy To Prod'
    sh 'bash ./k8s/dns.sh'


}
