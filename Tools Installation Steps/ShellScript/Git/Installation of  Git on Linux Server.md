#### Installation of Git on Linux Server

Here's a shell script to install Git on Linux Server and verify the installation:

```bash
#!/bin/bash

# Step 1: Install Git on Linux Server
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
