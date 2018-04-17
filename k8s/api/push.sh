#!/bin/bash
docker login -u _json_key -p https://gcr.io

IMAGES="spring-petclinic-discovery-server spring-petclinic-config-server spring-petclinic-api-gateway spring-petclinic-customers-service spring-petclinic-tracing-server spring-petclinic-vets-service spring-petclinic-visits-service"

for image in $IMAGES; do docker push $REPO/$image:$BUILD_NUMBER; done
