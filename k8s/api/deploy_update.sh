#!/bin/bash
PATH=$PATH:/var/jenkins_home/google-cloud-sdk/bin/
gcloud auth activate-service-account --key-file=/var/jenkins_home/auth.json --project concrete-198923
gcloud container clusters get-credentials petclinic-dev --zone us-central1-a
kubectl set image deployment/api-gateway master=gcr.io/concrete-198923/spring-petclinic-api-gateway:$BUILD_NUMBER
kubectl set image deployment/customers-service customers-service=gcr.io/concrete-198923/spring-petclinic-customers-service:$BUILD_NUMBER
kubectl set image deployment/tracing-server tracing-server=gcr.io/concrete-198923/spring-petclinic-tracing-server:$BUILD_NUMBER
kubectl set image deployment/vets-service vets-service=gcr.io/concrete-198923/spring-petclinic-vets-service:$BUILD_NUMBER
kubectl set image deployment/visits-service visits-service=gcr.io/concrete-198923/spring-petclinic-visits-service:$BUILD_NUMBER
