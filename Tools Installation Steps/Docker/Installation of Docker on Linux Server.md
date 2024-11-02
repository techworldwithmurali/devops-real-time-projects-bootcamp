### Installation of Docker on Linux Server

This guide provides instructions for installing Docker on a Linux server, checking its version, enabling and starting the Docker service, and verifying its status.

#### Prerequisites

- A Linux server (such as Amazon Linux) with sudo privileges.
- An active internet connection.

#### Steps for Installation

1. **Install Docker:**  
   Begin by installing Docker on your server. Use the following command to install Docker via the package manager:
   ```bash
   sudo yum install -y docker
   ```

2. **Check Docker Version:**  
   After the installation is complete, verify that Docker has been installed correctly by checking its version with:
   ```bash
   docker --version
   ```

3. **Enable Docker Service:**  
   Next, enable the Docker service to ensure that it starts automatically on system boot:
   ```bash
   sudo systemctl enable docker.service
   ```

4. **Start Docker Service:**  
   Now, start the Docker service using the following command:
   ```bash
   sudo systemctl start docker
   ```

5. **Check Docker Service Status:**  
   Finally, confirm that the Docker service is running by checking its status:
   ```bash
   sudo systemctl status docker
   ```
