#!/bin/bash
PATH=$PATH:/var/lib/jenkins/google-cloud-sdk/bin
COLOR=$(gsutil cat  gs://state-config/state)
cd ./k8s/

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

# change DNS

gcloud dns record-sets transaction start -z=redligth

gcloud dns record-sets transaction remove -z=redligth --type=CNAME --name="petclinicprod.redligth.com.br." --ttl 300 "petclinicblue.redligth.com.br."

gcloud dns record-sets transaction remove -z=redligth --type=CNAME --name="petclinicprod.redligth.com.br." --ttl 300 "petclinicgreen.redligth.com.br."

gcloud dns record-sets transaction add -z=redligth --type=CNAME --name="petclinicprod.redligth.com.br." --ttl 300 "petclinic$COLOR.redligth.com.br."
gcloud dns record-sets transaction execute -z=redligth

# update env

echo $COLOR > state
gsutil cp state -a public-read gs://state-config/
rm state

