#!/bin/bash
PATH=$PATH:/var/lib/jenkins/google-cloud-sdk/bin
COLOR=$(gsutil cat  gs://state-config/state)

if [ "$COLOR" = "blue" ]
then
    echo "Env At Blue, setting to green"
    COLOR=green
elif [ "$COLOR" = "green" ]
then
    echo "Env at Green, setting to blue"
    COLOR=blue
else
    echo "Not Cool, no color defined"
    exit 1
fi

# Enter Env Dir

cd ./k8s/$COLOR

# Auth Cluster
gcloud container clusters get-credentials petclinic-$COLOR-prod --zone us-central1-a

# Remove deployment old versions
kubectl delete services,pods,deployment --all
kubectl delete ingress api-gateway

# Apply Deploy Tag
for i in $(ls templates); do cat templates/$i | sed s/latest/$BUILD_NUMBER/g | sed 's/REPO/gcr.io\/acn-onboarding-devops/g'  >> $i; done

# Apply Deployment
kubectl create -f .
rm -rf *deployment*

