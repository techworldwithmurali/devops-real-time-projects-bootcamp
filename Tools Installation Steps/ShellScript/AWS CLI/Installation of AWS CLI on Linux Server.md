### Installation of AWS Cli on Linux Server

##### Note: For the latest releases and more information, visit the official  website:
**Official Webiste:** https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Here's a shell script to install the AWS CLI on Linux:

```bash
#!/bin/bash
# Title: AWS CLI Installation Script for Linux

# Step 1: Update the package list
echo "Updating package list..."
sudo yum update -y

# Step 2: Install the AWS CLI
echo "Downloading AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Step 3: Unzip the AWS CLI package
echo "Unzipping AWS CLI package..."
unzip awscliv2.zip

# Step 4: Run the installer
echo "Installing AWS CLI..."
sudo ./aws/install

# Step 5: Create a symbolic link to ensure the `aws` command is in PATH
echo "Creating symbolic link for AWS CLI..."
sudo ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/bin/aws

# Step 6: Check the AWS CLI version
echo "Checking AWS CLI version..."
aws --version

# Cleanup: Remove the downloaded files
echo "Cleaning up installation files..."
rm -rf awscliv2.zip aws

echo "AWS CLI installation completed successfully."
```

### Usage
1. Save the script as `install_aws_cli.sh`.
2. Make it executable and run it:

   ```bash
   chmod +x install_aws_cli.sh
   ./install_aws_cli.sh
   ```
