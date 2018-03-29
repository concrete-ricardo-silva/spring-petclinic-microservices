#!/bin/bash
PATH=$PATH:/var/jenkins_home/google-cloud-sdk/bin/
gcloud auth activate-service-account --key-file=/var/jenkins_home/auth.json --project concrete-198923
gcloud container clusters get-credentials petclinic-dev --zone us-central1-a
kubectl create -f 1-config-server-deployment.yaml
kubectl create -f 1-config-server-service.yaml
kubectl create -f 2-discovery-server-deployment.yaml
kubectl create -f 2-discovery-server-service.yaml
kubectl create -f admin-server-deployment.yaml
kubectl create -f api-gateway-deployment.yaml
kubectl create -f customers-service-deployment.yaml
kubectl create -f tracing-server-deployment.yaml
kubectl create -f vets-service-deployment.yaml
kubectl create -f visits-service-deployment.yaml
kubectl create -f api-gateway-service.yaml
kubectl create -f api-gateway-ingress.yaml
