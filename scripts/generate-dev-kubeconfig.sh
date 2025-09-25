#!/bin/bash

# Script to generate kubeconfig for developer user
# Usage: ./generate-dev-kubeconfig.sh <cluster-name> <region> <access-key-id> <secret-access-key>

CLUSTER_NAME=$1
REGION=$2
ACCESS_KEY_ID=$3
SECRET_ACCESS_KEY=$4

if [ $# -ne 4 ]; then
    echo "Usage: $0 <cluster-name> <region> <access-key-id> <secret-access-key>"
    exit 1
fi

# Create kubeconfig
cat > developer-kubeconfig.yaml << EOF
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: $(aws eks describe-cluster --name $CLUSTER_NAME --region $REGION --query 'cluster.certificateAuthority.data' --output text)
    server: $(aws eks describe-cluster --name $CLUSTER_NAME --region $REGION --query 'cluster.endpoint' --output text)
  name: $CLUSTER_NAME
contexts:
- context:
    cluster: $CLUSTER_NAME
    user: innovatemart-developer
  name: $CLUSTER_NAME
current-context: $CLUSTER_NAME
kind: Config
preferences: {}
users:
- name: innovatemart-developer
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: aws
      args:
        - eks
        - get-token
        - --cluster-name
        - $CLUSTER_NAME
        - --region
        - $REGION
      env:
        - name: AWS_ACCESS_KEY_ID
          value: $ACCESS_KEY_ID
        - name: AWS_SECRET_ACCESS_KEY
          value: $SECRET_ACCESS_KEY
EOF

echo "Developer kubeconfig generated: developer-kubeconfig.yaml"
echo "To use: export KUBECONFIG=\$(pwd)/developer-kubeconfig.yaml"