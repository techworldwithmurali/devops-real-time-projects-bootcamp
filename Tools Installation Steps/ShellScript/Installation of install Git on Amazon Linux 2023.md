#### Installation of install Git on Amazon Linux 2023

Here's a shell script to install Git on Amazon Linux 2023 and verify the installation:

```bash
#!/bin/bash
# Title: Git Installation Script for Amazon Linux 2023

# Step 1: Install Git on Amazon Linux 2023
echo "Installing Git..."
sudo yum install -y git

# Step 2: Check the Git version
echo "Checking Git version..."
git --version
```

### Instructions
1. Save this script as `install_git.sh`.
2. Make the script executable and run it:

   ```bash
   chmod +x install_git.sh
   ./install_git.sh
   ```

This script installs Git and displays the installed version.
