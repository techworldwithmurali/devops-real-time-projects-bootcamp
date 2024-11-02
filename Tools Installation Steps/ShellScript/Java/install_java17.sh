#!/bin/bash

# Step 1: Install Java 17 on Amazon Linux 2023
echo "Installing Java 17..."
sudo yum install -y java-17-amazon-corretto-devel

# Step 2: Check the Java version
echo "Checking Java version..."
java --version
