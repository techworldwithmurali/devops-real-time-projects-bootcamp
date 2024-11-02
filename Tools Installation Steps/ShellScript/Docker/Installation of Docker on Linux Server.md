#### Installation of Docker on Linux DServer

Here's a shell script to install Docker on  Linux, check its version, enable and start the Docker service, and then check its status:

```bash
#!/bin/bash
# Title: Docker Installation and Setup Script for Amazon Linux

# Step 1: Install Docker
echo "Installing Docker..."
sudo yum install -y docker

# Step 2: Check Docker version
echo "Checking Docker version..."
docker --version

# Step 3: Enable Docker service
echo "Enabling Docker service..."
sudo systemctl enable docker.service

# Step 4: Start Docker service
echo "Starting Docker service..."
sudo systemctl start docker

# Step 5: Check Docker service status
echo "Checking Docker service status..."
sudo systemctl status docker
```

### Instructions
1. Save this script as `install_docker.sh`.
2. Make the script executable and run it:

   ```bash
   chmod +x install_docker.sh
   ./install_docker.sh
   ```

This script installs Docker, enables and starts the Docker service, and then displays the service status.
