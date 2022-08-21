#!/bin/bash
RESOURCE_GROUP_NAME=$1
LOCATION=$2
# generate cluster
./aks-engine deploy --dns-prefix "$RESOURCE_GROUP_NAME" \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --location "$LOCATION" \
    --api-model ./kubernetes.json \
    --auto-suffix
# build service A docker image
docker build ./btcExchangeRateApi -t service-a-node-web-app
# build service B docker image
docker build ./simpleRestApi -t service-b-node-web-app
# create deployment 1 and 2 for services A and B. Cluster ip A and B
kubectl apply -f deployments.yaml
# create network rule so the 2 services cannot communicate with each other
# setup ingress controller taken from the official NGINX page located here: https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml
# ingress controller rules for service 
kubectl apply -f ingress.yaml