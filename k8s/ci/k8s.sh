#!/bin/bash
gcloud container clusters get-credentials jenkins-dev --zone us-central1-a
kubectl create ns jenkins
kubectl create secret generic jenkins --from-file=options --namespace=jenkins
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value account)
kubectl apply -f .
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=jenkins/O=jenkins"
kubectl create secret generic tls --from-file=/tmp/tls.crt --from-file=/tmp/tls.key --namespace jenkins
kubectl apply -f lb/ingress.yaml
