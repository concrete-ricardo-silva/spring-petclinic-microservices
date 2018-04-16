# Get Color

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

cd k8s/$COLOR/

# Auth Cluster

kubectl get-credentials petclinic-$COLOR-prod

# Remove deployment old versions
# kubectl delete deployment iuiui iuiui iuiu iuiui 

# Apply Deploy Tag
for i in $(ls templates); do cat templates/$i | sed s/latest/$BUILD_NUMBER/g  >> $i; done

# Apply Deployment
kubectl apply -f .

# Waiting tests

# change DNS

gcloud dns record-sets transaction start -z=redligth
gcloud dns record-sets transaction add -z=redligth --name="petclinicprod.redligth.com.br" --type=CNAME --ttl=300 "petclinic$COLOR.redligth.com.br"
gcloud dns record-sets transaction execute -z=redligth


# update env

echo $COLOR > state
gsutil cp state gs://state-config/



