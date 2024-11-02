#!/bin/bash
# Title: Helm 3 Installation Script for Linux

# Step 1: Update the package list
echo "Updating package list..."
sudo yum update -y

# Step 2: Install curl if it's not already installed
echo "Installing curl..."
sudo yum install -y curl

# Step 3: Download the Helm 3 binary
echo "Downloading Helm 3..."
curl -fsSL https://get.helm.sh/helm-v3.11.3-linux-amd64.tar.gz -o helm.tar.gz

# Step 4: Extract the downloaded tarball
echo "Extracting Helm..."
tar -zxvf helm.tar.gz

# Step 5: Move the Helm binary to /usr/local/bin/
echo "Installing Helm to /usr/local/bin/..."
sudo mv linux-amd64/helm /usr/local/bin/helm

# Step 6: Verify the installation
echo "Checking Helm version..."
helm version --short

# Cleanup: Remove the downloaded files
echo "Cleaning up installation files..."
rm -rf helm.tar.gz linux-amd64

echo "Helm 3 installation completed successfully."
