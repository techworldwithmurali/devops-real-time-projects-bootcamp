### Installation of kubectl on Linux Server

This guide provides instructions for installing `kubectl`, the command-line interface for Kubernetes, on a Linux server.

#### Note
For the latest releases and detailed information, you can visit the official website:  
**Official Website:** https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

#### Installation Steps

1. **Set the Kubernetes Version:**  
   Determine which version of `kubectl` you want to install. For this guide, we will use version **1.31.0**.

2. **Download the kubectl Binary:**  
   To download the `kubectl` binary, run the following command in your terminal:
   ```
   curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.0/2024-09-12/bin/linux/amd64/kubectl
   ```

3. **Apply Execute Permissions:**  
   After downloading, you'll need to give the binary execute permissions. You can do this by running:
   ```
   chmod +x ./kubectl
   ```

4. **Move the kubectl Binary:**  
   To make `kubectl` accessible from anywhere, move it to the `/usr/local/bin/` directory:
   ```
   sudo mv kubectl /usr/local/bin/
   ```

5. **Verify the Installation:**  
   Once `kubectl` is installed, you should verify the installation by checking the version. Use the following command:
   ```
   kubectl version --client
   ```
