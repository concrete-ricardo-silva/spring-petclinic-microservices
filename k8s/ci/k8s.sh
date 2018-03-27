#!/bin/bash
gcloud container clusters get-credentials jenkins-dev --zone us-central1-a
kubectl create secret generic jenkins --from-file=options
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value account)
kubectl apply -f .
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=jenkins/O=jenkins"
kubectl create secret generic tls --from-file=/tmp/tls.crt --from-file=/tmp/tls.key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls-api.key -out /tmp/tls-api.crt -subj "/CN=Petclinic/O=PetClinic"
kubectl create secret generic tls-api --from-file=/tmp/tls-api.crt --from-file=/tmp/tls-api.key
kubectl apply -f lb/ingress.yaml
