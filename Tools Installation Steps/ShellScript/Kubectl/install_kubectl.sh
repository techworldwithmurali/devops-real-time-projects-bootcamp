#!/bin/bash
# Title: Kubernetes CLI (kubectl) Installation Script

# Step 1: Set the Kubernetes version
KUBECTL_VERSION=1.31.0

# Step 2: Download the kubectl binary from Amazon S3
echo "Downloading kubectl binary for Kubernetes version $KUBECTL_VERSION..."
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/$KUBECTL_VERSION/2024-09-12/bin/linux/amd64/kubectl

# Step 3: Apply execute permissions to the binary
echo "Applying execute permissions to kubectl..."
chmod +x ./kubectl

# Step 4: Move the kubectl binary to /usr/local/bin/
echo "Moving kubectl to /usr/local/bin/..."
sudo mv kubectl /usr/local/bin/

# Step 5: Check the kubectl version
echo "Checking kubectl version..."
kubectl version --client

echo "kubectl installation completed successfully."
