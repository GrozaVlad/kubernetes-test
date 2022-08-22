#!/bin/bash
# create deployment 1 and 2 for services A and B. Cluster ip A and B
kubectl apply -f deployments.yaml
# setup ingress controller taken from the official NGINX page located here: https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml
# ingress controller rules for services, we will need to wait 3-5 minutes for the ingress controller pod to become active otherwise the script will fail 
sleep 300
kubectl apply -f ingress.yaml
# create network rule so the 2 services cannot communicate with each other
kubectl apply -f network_policy.yaml