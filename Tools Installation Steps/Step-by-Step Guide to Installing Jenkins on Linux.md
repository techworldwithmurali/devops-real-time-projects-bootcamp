
### Step-by-Step Guide to Installing Jenkins on Linux Serever (Amazon Linux 2023 / Redhat)

In this session, we will discuss how to install Jenkins on Linux Serever.

#### Step 1: Install Java

First, install Java using the command below:

```bash
sudo yum install java-11-amazon-corretto-devel
```


#### Step 1.1: Verify Java Installation

Check if Java is installed:

```bash
sudo java -version
```

#### Step 2: Install EPEL Repository

Jenkins is not available in the default repositories of CentOS 7/Amazon Linux, but it's available in the EPEL repository. 

##### For CentOS 7:

```bash
sudo yum install epel-release -y
```

##### For Amazon Linux:

```bash
sudo amazon-linux-extras install epel -y
```

#### Step 3: Enable the Jenkins Repository

Import the GPG key using the curl command:

```bash
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
```

#### Step 4: Import the Jenkins GPG Key

Add the Jenkins repository to your system:

```bash
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
```

#### Step 5: Install Jenkins

Install the latest stable version of Jenkins:

```bash
sudo yum install jenkins -y
jenkins --version
```

#### Step 6: Enable Jenkins Service on Boot

Enable the Jenkins service to start on system boot:

```bash
sudo systemctl enable jenkins
```

#### Step 7: Start Jenkins Service

Start the Jenkins service:

```bash
sudo systemctl start jenkins
```
*Or:*

```bash
sudo service jenkins start
```

#### Step 8: Check Jenkins Service Status

Verify the status of the Jenkins service:

```bash
sudo systemctl status jenkins
```
*Or:*

```bash
sudo service jenkins status
```

#### Step 9: Stop Jenkins Service

To stop the Jenkins service, use:

```bash
sudo systemctl stop jenkins
```
*Or:*

```bash
sudo service jenkins stop
```

#### Step 10: Restart Jenkins Service

To restart the service:

```bash
sudo systemctl restart jenkins
```
*Or:*

```bash
sudo service jenkins restart
```

#### Step 11: Enable Port 8080

##### For On-Premise Servers:

```bash
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload
```

##### For AWS EC2 Instances:

Open port 8080 in the Inbound rules of your Security Groups.

##### Note:
If port 8080 is not enabled, you won't be able to access the Jenkins GUI.

#### Step 12: Access Jenkins GUI

To set up Jenkins, open your browser and navigate to:

```
http://your_ip_or_domain:8080
```

##### Example:
```
http://54.175.240.24:8080
```

#### Step 13: Retrieve Administrator Password

Print the password on your terminal:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

##### Output:
*(Add the expected output here)*

#### Step 14: Complete Setup

Copy the password from your terminal, paste it into the Administrator password field, and click Continue.

#### Step 15: Install Plugins

You will be presented with two options: ‘Install using suggested plugins‘ or ‘Select plugins to install‘. Click on ‘Install using suggested plugins‘.

#### Step 16: Set Up Administrative User

After plugin installation, fill out the required information to set up the first administrative user, then click Save and Continue.

##### Instance Configuration:

Leave the default Jenkins URL as is, and click ‘Save and Finish‘.

At this point, Jenkins setup is complete. Click on ‘Start using Jenkins‘ to access the dashboard.

#### Step 17: Create the Target Group

Create a target group and add the instance with port 8080. Set the health check path to `/login`.

**Target Group Name:** `jenkins-tg`

#### Step 18: Create the Load Balancer

Create the load balancer and add listeners for both HTTP (80) and HTTPS (443).

**Load Balancer Name:** `jenkins-alb`

#### Step 19: Create the A Record in Route 53

Create an A record in Route 53 to point to the Jenkins load balancer.

**Record Name:** `jenkins.techworldwithmurali.in`

#### Step 20: Access Jenkins

Access Jenkins using the following URL:

```
https://jenkins.techworldwithmurali.in
```

#### Step 21: Maintain Persistent Data

To maintain persistent data, use EFS to mount the `/var/lib/jenkins` path.

**EFS Name:** `Jenkins-efs`

##### Mount the EFS

*Use the appropriate command to mount the EFS.*

##### Verify Mounting

Check whether it is mounted using:

```bash
df -h
```

##### Set the fstab Entry

*Add the fstab entry to ensure it mounts on boot.*

#### Conclusion

In this tutorial, you have learned how to install and complete the initial configuration of Jenkins on a Linux server. If you have any questions, please leave a comment below.

**Thank you for watching this video. We will see you in the next video.**
```
