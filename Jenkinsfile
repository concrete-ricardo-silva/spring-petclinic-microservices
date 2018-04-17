node {
  checkout scm
  def COLOR = sh script: 'curl https://storage.googleapis.com/state-config/state'
  try {
  stage 'Build APPs'
    sh("export DOCKER_HOST=unix:///var/run/docker.sock & mvn clean install -PbuildDocker -DskipTests -DREPO=${env.REPO} -DBUILD_NUMBER=${env.BUILD_NUMBER}")
  
  stage 'Push Images'
    sh 'bash ./k8s/push.sh'
  
  stage 'Deploy To New Color'
    sh 'export COLOR=${COLOR} && bash ./k8s/blue_green.sh'
      waitUntil {
      sh 'echo "petclinic.redligth.com.br"' 
      }
  
  stage 'Deploy To Prod'
    sh 'export COLOR=${COLOR} &&  bash ./k8s/dns.sh'
  }catch (err) {

        currentBuild.result = "FAILURE"

            mail body: "project build error is here: ${env.BUILD_URL}" ,
            from: 'xxxx@yyyy.com',
            replyTo: 'yyyy@yyyy.com',
            subject: 'project build failed',
            to: 'zzzz@yyyyy.com'

        throw err
    }
  }
  




