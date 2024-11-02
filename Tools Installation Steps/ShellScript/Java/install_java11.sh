#!/bin/bash

# Step 1: Install Java 11 on Amazon Linux 2023
echo "Installing Java 11..."
sudo yum install -y java-11-amazon-corretto-devel

# Step 2: Check the Java version
echo "Checking Java version..."
java --version
