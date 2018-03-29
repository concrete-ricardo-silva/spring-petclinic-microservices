#!/bin/bash
docker login -u _json_key -p "$(cat /var/jenkins_home/auth.json )" https://gcr.io
IMAGES="spring-petclinic-api-gateway spring-petclinic-customers-service spring-petclinic-tracing-server spring-petclinic-vets-service spring-petclinic-visits-service"
for image in $IMAGES; do docker push gcr.io/concrete-198923/$image:$BUILD_NUMBER; done
