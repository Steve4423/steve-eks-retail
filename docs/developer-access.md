# Developer Access Guide

## Overview
This document provides instructions for the development team to access the InnovateMart EKS cluster with read-only permissions.

## IAM User Details
- **Username**: `innovatemart-developer`
- **Permissions**: Read-only access to EKS cluster resources
- **Capabilities**: View pods, services, logs, deployments, and other Kubernetes resources

## Setup Instructions

### 1. AWS Credentials
Use the provided AWS credentials:
```bash
export AWS_ACCESS_KEY_ID=<provided-access-key-id>
export AWS_SECRET_ACCESS_KEY=<provided-secret-access-key>
export AWS_DEFAULT_REGION=<cluster-region>
```

### 2. Generate Kubeconfig
Run the provided script to generate your kubeconfig:
```bash
chmod +x scripts/generate-dev-kubeconfig.sh
./scripts/generate-dev-kubeconfig.sh <cluster-name> <region> <access-key-id> <secret-access-key>
```

### 3. Use Kubeconfig
Set the kubeconfig environment variable:
```bash
export KUBECONFIG=$(pwd)/developer-kubeconfig.yaml
```

## Available Commands

### View Pods
```bash
kubectl get pods --all-namespaces
kubectl describe pod <pod-name> -n <namespace>
```

### View Services
```bash
kubectl get services --all-namespaces
kubectl describe service <service-name> -n <namespace>
```

### View Logs
```bash
kubectl logs <pod-name> -n <namespace>
kubectl logs -f <pod-name> -n <namespace>  # Follow logs
```

### View Deployments
```bash
kubectl get deployments --all-namespaces
kubectl describe deployment <deployment-name> -n <namespace>
```

### View Application Status
```bash
# Check retail store application pods
kubectl get pods -n retail-store

# Check application services
kubectl get services -n retail-store

# View application logs
kubectl logs -l app=ui -n retail-store
```

## Restrictions
- **Read-only access**: Cannot create, update, or delete resources
- **No cluster administration**: Cannot modify cluster settings or RBAC
- **No secrets access**: Cannot view secret values (only metadata)

## Troubleshooting

### Authentication Issues
If you encounter authentication errors:
1. Verify AWS credentials are correct
2. Ensure the kubeconfig was generated properly
3. Check that the IAM user has been properly mapped in the cluster

### Permission Denied
If you get permission denied errors:
1. Verify you're using the correct kubeconfig
2. Check that you're not trying to perform write operations
3. Contact the DevOps team if you need additional permissions

## Support
For issues or additional access requirements, contact the DevOps team.