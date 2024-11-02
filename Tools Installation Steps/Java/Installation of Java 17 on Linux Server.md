### Installation of Java 17 on Linux Server

This guide explains how to install Java 17 on Amazon Linux 2023.

### Prerequisites

- An Amazon Linux 2023 instance with sudo privileges.

### Installation Steps

1. **Install Java 17**

   Open a terminal and run the following command to install Java 17:

   ```bash
   sudo yum install -y java-17-amazon-corretto-devel
   ```

2. **Check the Java Version**

   After installation, verify that Java has been installed successfully by checking its version:

   ```bash
   java --version
   ```
