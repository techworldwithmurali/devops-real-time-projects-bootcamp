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
