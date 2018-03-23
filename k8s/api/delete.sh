#!/bin/bash
LIST="admin-server
config-server
customers-service
discovery-server
tracing-server
vets-service
visits-service
api-gateway"

for i in $LIST; do kubectl delete service $i; done
for i in $LIST; do kubectl delete deploy $i; done
