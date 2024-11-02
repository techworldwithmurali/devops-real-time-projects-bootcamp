### Installation of Helm on Linux Server

This document outlines the steps to install Helm 3 on a Linux server.

#### Note
For the latest releases, visit the official Helm website:  
**Official Website:** [Helm Releases](https://github.com/helm/helm/releases)

#### Steps for Installation

1. **Update the Package List:**  
   Start by updating the package list on your server to ensure that you have the latest package information:
   ```bash
   sudo yum update -y
   ```

2. **Install curl:**  
   If `curl` is not already installed on your system, install it using the following command:
   ```bash
   sudo yum install -y curl
   ```

3. **Download the Helm 3 Binary:**  
   Download the Helm 3 binary using `curl` with the command below:
   ```bash
   curl -fsSL https://get.helm.sh/helm-v3.11.3-linux-amd64.tar.gz -o helm.tar.gz
   ```

4. **Extract the Downloaded Tarball:**  
   Once the download is complete, extract the contents of the tarball:
   ```bash
   tar -zxvf helm.tar.gz
   ```

5. **Move the Helm Binary:**  
   Move the Helm binary to `/usr/local/bin/` to make it accessible from anywhere in your terminal:
   ```bash
   sudo mv linux-amd64/helm /usr/local/bin/helm
   ```

6. **Verify the Installation:**  
   Check that Helm has been installed correctly by verifying its version:
   ```bash
   helm version --short
   ```

7. **Cleanup:**  
   After the installation, remove the downloaded files to keep your server clean:
   ```bash
   rm -rf helm.tar.gz linux-amd64
   ```
