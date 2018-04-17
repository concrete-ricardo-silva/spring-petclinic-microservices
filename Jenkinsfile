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
        sh 'bash ./k8s/deploy.sh'
    } catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }

    stage 'Promotion' 
        echo 'Do the tests at New Color'
        waitUntil {
          script {
            def r = sh script: 'color=$(/var/lib/jenkins/google-cloud-sdk/bin/gsutil cat gs://state-config/state); if [  "$color" == blue ]; then color=green; else color=blue; fi && wget -q http://petclinic$color.redligth.com.br/ -O /dev/null', returnStatus: true
          return (r == 0);
       }
    }
     
    
    
    stage 'Deploy To Prod'
    try {
        sh 'bash ./k8s/dns.sh'
    } catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }
}
