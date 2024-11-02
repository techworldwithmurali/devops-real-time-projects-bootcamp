### Installation of AWS CLI on Linux Server

This document provides instructions for installing the AWS CLI (Command Line Interface) on a Linux server.

#### Prerequisites

- A Linux server with sudo privileges.
- An active internet connection.

#### Steps for Installation

1. **Update the Package List:**  
   Start by updating the package list on your server. This ensures that you have the latest package information and can install the AWS CLI without any issues. Run the following command:
   ```bash
   sudo yum update -y
   ```

2. **Download the AWS CLI:**  
   Next, download the AWS CLI installation package using `curl`. This command fetches the installation script for the AWS CLI version 2:
   ```bash
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   ```

3. **Unzip the Package:**  
   Once the download is complete, unzip the AWS CLI package using the following command:
   ```bash
   unzip awscliv2.zip
   ```

4. **Run the Installer:**  
   After extracting the files, run the installation script to install the AWS CLI:
   ```bash
   sudo ./aws/install
   ```

5. **Create a Symbolic Link:**  
   To ensure that the `aws` command is available in your system's PATH, create a symbolic link using:
   ```bash
   sudo ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/bin/aws
   ```

6. **Check the AWS CLI Version:**  
   Finally, verify the installation by checking the AWS CLI version with the following command:
   ```bash
   aws --version
   ```

7. **Cleanup:**  
   After the installation, remove the downloaded files to keep your server clean:
   ```bash
   rm -rf awscliv2.zip aws
   ```
