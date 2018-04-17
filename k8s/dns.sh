#!/bin/bash

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
rm *deployment*

