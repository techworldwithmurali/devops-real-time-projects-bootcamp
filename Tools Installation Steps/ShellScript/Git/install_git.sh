#!/bin/bash

# Step 1: Install Git on Linux Server
echo "Installing Git..."
sudo yum install -y git

# Step 2: Check the Git version
echo "Checking Git version..."
git --version
