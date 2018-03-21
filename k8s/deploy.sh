#!/bin/bash
kubectl create -f 1-config-server-deployment.yaml
kubectl create -f 1-config-server-service.yaml
kubectl create -f 2-discovery-server-deployment.yaml
kubectl create -f 2-discovery-server-service.yaml
kubectl create -f admin-server-deployment.yaml
kubectl create -f api-gateway-deployment.yaml
kubectl create -f customers-service-deployment.yaml
kubectl create -f tracing-server-deployment.yaml
kubectl create -f vets-service-deployment.yaml
kubectl create -f visits-service-deployment.yaml
kubectl expose deployment api-gateway --type=LoadBalancer --port 80 --target-port 8080
