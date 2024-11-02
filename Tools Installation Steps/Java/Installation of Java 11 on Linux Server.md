# Installation of Java 11 on Linux Server

This guide explains how to install Java 11 on  Linux Server. 

## Prerequisites

- Amazon Linux 2023 instance with sudo privileges.

## Installation Steps

1. **Install Java 11**

   Open a terminal and run the following command to install Java 11:

   ```bash
   sudo yum install -y java-11-amazon-corretto-devel
   ```

2. **Check the Java Version**

   After installation, you can verify that Java has been installed successfully by checking its version:

   ```bash
   java --version
   ```
