# Get Color
PATH=$PATH:/var/lib/jenkins/google-cloud-sdk/bin
COLOR=$(gsutil cat  gs://state-config/state)
cd ./k8s/

if [ "$COLOR" = "blue" ]
then
    echo "Env At Blue, setting to green"
    COLOR=green
    OLD_COLOR=blue
elif [ "$COLOR" = "green" ]
then
    echo "Env at Green, setting to blue"
    COLOR=blue
    OLD_COLOR=green
else
    echo "Not Cool, no color defined"
    exit 1
fi 

# Enter Env Dir

cd $COLOR

# Auth Cluster
gcloud container clusters get-credentials petclinic-$COLOR-prod --zone us-central1-a

# Remove deployment old versions
kubectl delete  deployment admin-server  api-gateway   config-server  customers-service  discovery-server tracing-server   vets-service visits-service

# Apply Deploy Tag
for i in $(ls templates); do cat templates/$i | sed s/latest/$BUILD_NUMBER/g | sed 's/REPO/gcr.io\/acn-onboarding-devops/g'  >> $i; done

# Apply Deployment
kubectl create -f .

# Waiting tests

# change DNS

gcloud dns record-sets transaction start -z=redligth
gcloud dns record-sets transaction remove -z=redligth --type=CNAME --name="petclinicprod.redligth.com.br." --ttl 300 "petclinic$OLD_COLOR.redligth.com.br."
gcloud dns record-sets transaction add -z=redligth --type=CNAME --name="petclinicprod.redligth.com.br." --ttl 300 "petclinic$COLOR.redligth.com.br."
gcloud dns record-sets transaction execute -z=redligth


# update env

echo $COLOR > state
gsutil cp state gs://state-config/
rm state
rm *deployment*


