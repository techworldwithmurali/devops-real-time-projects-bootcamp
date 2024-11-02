### Installation of kubectl on Linux Server
##### Note: For the latest releases and more information, visit the official  website:
**Official Webiste:** https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

```bash
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
```

### Instructions
1. Save the script as `install_kubectl.sh`.
2. Make it executable and run it:

   ```bash
   chmod +x install_kubectl.sh
   ./install_kubectl.sh
   ```

This script will install the specified version of `kubectl` and verify the installation by displaying the version information.
