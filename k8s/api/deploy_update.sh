#!/bin/bash
PATH=$PATH:/var/jenkins_home/google-cloud-sdk/bin/
gcloud auth activate-service-account --key-file=/var/jenkins_home/auth.json --project concrete-198923
gcloud container clusters get-credentials petclinic-dev --zone us-central1-a
APPS="spring-petclinic-customers-service spring-petclinic-tracing-server spring-petclinic-vets-service spring-petclinic-visits-service api-gateway"

for app in $APPS; do kubectl set image deployment/$app $app=gcr.io/concrete-198923/spring-petclinic-$app:$BUILD_NUMBER; done
