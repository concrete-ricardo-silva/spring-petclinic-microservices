node {
    checkout scm
    try {
        stage 'Build APPs'
        sh("export DOCKER_HOST=unix:///var/run/docker.sock & mvn clean install -PbuildDocker -DskipTests -DREPO=${env.REPO} -DBUILD_NUMBER=${env.BUILD_NUMBER}")
    } catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }
    stage 'Push Images'
    try {
        sh 'bash ./k8s/push.sh'
    } catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }

    stage 'Deploy To New Color'
    try {
        sh 'export COLOR=$(curl https://storage.googleapis.com/state-config/state) && bash ./k8s/deploy.sh'
    } catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }

    stage 'Promotion' {
        sh 'export COLOR=$(curl https://storage.googleapis.com/state-config/state) && echo http://petclinic$COLOR.redligth.com.br./'
        input 'Deploy to Production?'
     }
    
    
    stage 'Deploy To Prod'
    try {
        sh 'export COLOR=$(curl https://storage.googleapis.com/state-config/state) && bash ./k8s/dns.sh'
    } catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }
}
