### Installation of Maven on Linux Server

**Note:** For the latest releases and more information, visit the official website: https://maven.apache.org/download.cgi

To install Maven on a Linux server, follow these steps:

1. **Prerequisites:** Ensure that your user has sudo privileges to install packages.

2. **Maven Version:** Determine the version of Maven you wish to install. For this example, we will use version 3.9.9.

3. **Install Java 17:** 
   - First, install Java 17 using the following command:
     ```
     sudo yum install java-17-amazon-corretto-devel -y
     ```
   - After installation, check whether Java is installed by running:
     ```
     java -version
     ```

4. **Install Apache Maven:**
   - Download Apache Maven by navigating to the `/opt/` directory:
     ```
     cd /opt/
     ```
   - Use `wget` to download the specified version of Maven:
     ```
     sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
     ```
   - Extract the downloaded archive:
     ```
     sudo tar -xvf apache-maven-3.9.9-bin.tar.gz
     ```
   - Rename the extracted folder to a simpler name:
     ```
     sudo mv apache-maven-3.9.9 maven
     ```

5. **Configure Apache Maven Environment Variables:**
   - Create a new file for Maven environment variables:

**vim  /etc/profile.d/maven.sh**
    
# Apache Maven Environment Variables
# MAVEN_HOME for Maven 1 - M2_HOME for Maven 2
export M2_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}

     
   - Set execute permissions for the configuration file:
     ```
     sudo chmod +x /etc/profile.d/maven.sh
     ```
   - Load the Maven environment configuration:
     ```
     source /etc/profile.d/maven.sh
     ```

6. **Verify Maven Installation:** 
   - Check the installed version of Maven by running:
     ```
     mvn --version
     ```
