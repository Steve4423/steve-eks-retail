#!/bin/bash

# Deploy retail store application to EKS cluster
# Usage: ./deploy-retail-app.sh

set -e

echo "Deploying retail store application..."

# Apply the retail store application manifests
kubectl apply -f https://github.com/aws-containers/retail-store-sample-app/releases/latest/download/kubernetes.yaml

echo "Waiting for deployments to be ready..."
kubectl wait --for=condition=available deployments --all --timeout=300s

echo "Getting service information..."
kubectl get services

echo "Retail store application deployed successfully!"
echo "To access the application, get the LoadBalancer URL:"
echo "kubectl get svc ui"