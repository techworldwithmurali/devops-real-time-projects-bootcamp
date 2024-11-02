#!/bin/bash

# Prerequisites: Ensure the user has sudo privileges to install packages

# Maven version to install
MAVEN_VERSION=3.8.6

# Step 1: Install Java 17
echo "Installing Java 17..."
sudo yum install java-17-amazon-corretto-devel -y

# Step 1.1: Check whether Java is installed
echo "Checking Java version..."
java -version

# Step 2: Install Apache Maven

# Step 2.1: Download Apache Maven
echo "Downloading Apache Maven version $MAVEN_VERSION..."
cd /opt/
sudo wget https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

# Step 2.2: Extract the downloaded archive
echo "Extracting Apache Maven..."
sudo tar -xvf apache-maven-${MAVEN_VERSION}-bin.tar.gz

# Step 2.3: Rename the extracted folder
echo "Renaming Maven directory..."
sudo mv apache-maven-${MAVEN_VERSION} maven

# Step 2.4: Configure Apache Maven Environment Variables
echo "Configuring Maven environment variables..."
sudo bash -c 'cat > /etc/profile.d/maven.sh <<EOF
# Apache Maven Environment Variables
export M2_HOME=/opt/maven
export PATH=\${M2_HOME}/bin:\${PATH}
EOF'

# Step 2.5: Set execute permissions for the Maven configuration
echo "Setting execute permissions for maven.sh..."
sudo chmod +x /etc/profile.d/maven.sh

# Step 2.6: Load the Maven environment configuration
echo "Loading Maven environment configuration..."
source /etc/profile.d/maven.sh

# Step 2.7: Verify Maven installation
echo "Checking Maven version..."
mvn --version

echo "Apache Maven version $MAVEN_VERSION installation completed successfully on Linux Server."
