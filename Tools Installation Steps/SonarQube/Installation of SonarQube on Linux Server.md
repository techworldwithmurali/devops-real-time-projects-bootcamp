# Installation of SonarQube on Linux Server.

In this session, we are going to discuss the installation of SonarQube 9.9.7 (Community Edition) on a Linux server.

## Prerequisites
- Your user must have sudo privileges to be able to install the packages.
- Minimum 2 VCPU & 4 GB Memory.
- Amazon Linux 2023 Server
- ALB and Target Group
- Route 53

> **Note:** If you are installing SonarQube 7.1 (or newer), make sure it is run as a non-root user. Newer versions of Elasticsearch cannot be run as root.

## Step 1: Install Java 17
```bash
sudo yum install java-17-amazon-corretto-devel -y
```

## Step 1.1: Check Java Installation
Use the following command to check whether Java is installed:
```bash
sudo java -version
```

## Step 2: Download SonarQube 9.9.7
Download the SonarQube 9.9.7 zip file under the `/opt` directory from the official page:
```bash
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.7.96285.zip
```
Website Link: 

https://www.sonarsource.com/products/sonarqube/downloads/historical-downloads/

## Step 3: Unzip the Downloaded Archive
Unzip the downloaded archive file using the following command:
```bash
unzip sonarqube-9.9.7.96285.zip
```

## Step 4: Rename the SonarQube Folder
Rename the SonarQube folder using the following command:
```bash
mv sonarqube-9.9.7.96285 sonarqube
```

## Step 5: Create a New User for SonarQube
As a good security practice, it is not recommended to run the SonarQube service with root privileges.

### Step 5.1: Create the Sonar User
```bash
sudo adduser sonar
# or
sudo useradd sonar
```
### Step 5.2: Verify Sonar User Creation
Check whether the sonar user is created using the `id` command:
```bash
sudo id sonar
```
### Step 5.3 Creat ethe password for sonar user 
```bash
passwd sonar
```
### Step 5.4: Change Ownership of the Sonar Directory
```bash
sudo chown -R sonar:sonar sonarqube
```

## Step 6: Update SonarQube Configuration
By default, SonarQube will run as a root user. You need to update the Sonar user under `/opt/sonarqube/bin/linux-x86-64/sonar.sh`.

Uncomment the `RUN_AS_USER` parameter and set it to the sonar user:
```bash
RUN_AS_USER="sonar"
```
## Step 7: Run SonarQube
Switch to the sonar user and run the SonarQube shell script (`sonar.sh`) under `/opt/sonarqube/bin/linux-x86-64/` directory.

> **Note:** If you encounter a `java.lang.IllegalStateException` error during SonarQube startup, delete the `tmp` directory under `/opt/sonar` and start SonarQube again.

## Step 8: Check SonarQube Status
To check the status of SonarQube, use the following command under `/opt/sonarqube/bin/linux-x86-64` directory:
```bash
sh sonar.sh status
```
**Note:** If the RUN_AS_USER parameter is not added in the /opt/sonarqube/bin/linux-x86-64/sonar.sh file, switch to the Sonar user and then run SonarQube:

```bash
sudo su - sonar
sh /opt/sonarqube/bin/linux-x86-64/sonar.sh start

```
## Step 9: Stop SonarQube
To stop SonarQube, use the following command under `/opt/sonarqube/bin/linux-x86-64/` directory:
```bash
sh sonar.sh stop
```

## Step 10: Restart SonarQube
To restart SonarQube, use the following command under `/opt/sonarqube/bin/linux-x86-64` directory:
```bash
sh sonar.sh restart
```

## Step 11: Setup SonarQube as a Service
Create the `sonar.service` file under the `/etc/systemd/system/` directory:
```bash
sudo vim /etc/systemd/system/sonarqube.service
```

### Content of `sonar.service` file:
```ini
[Unit]
Description=SonarQube service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=sonar
Group=sonar
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
```
## Change the Ownership of sonar.service
```bash
chown sonar:sonar /etc/systemd/system/sonarqube.service
```
## Change the Permissions of sonar.service
```bash
chmod 755 /etc/systemd/system/sonarqube.service
```

## Step 12: Enable the SonarQube Service
```bash
sudo systemctl enable sonarqube
```
## Step 13: Start the SonarQube Service
To start the SonarQube service, use:
```bash
sudo systemctl start sonarqube
# or
sudo service sonar start
```

## Step 14: Stop the SonarQube Service
To stop the SonarQube service, use:
```bash
sudo systemctl stop sonarqube
# or
sudo service sonar sonarqube
```

## Step 15: Check the Status of the SonarQube Service
```bash
sudo systemctl status sonarqube
# or
sudo service sonar sonarqube
```
> **Note:** If you are running as a service, you should stop the SonarQube shell script under `/opt/sonar/bin/linux-x86-64`. Otherwise, the service won't be up and running.

## Step 16: Restart the SonarQube Service
```bash
sudo systemctl restart sonarqube
# or
sudo service sonarqube restart
```

## Step 17: Enable Port 9000
To access the SonarQube GUI, enable port `9000`:

### For On-Premise Server:
```bash
sudo firewall-cmd --permanent --zone=public --add-port=9000/tcp
sudo firewall-cmd --reload
```

### For AWS EC2 Instance:
Open the Inbound rules for port `9000` in Security Groups for your server.

### Example:
Add the `9000` port number in the Inbound rule.

> **Note:** If port `9000` is not enabled, you cannot access the SonarQube GUI.

## Step 18: Access the SonarQube GUI
Open any browser and type your domain or IP address followed by port `9000`:
```
http://your_ip_or_domain:9000
```

### Example:
```
http://10.70.144.5:9000/
```

## Step 19: Login to SonarQube
Use the default username and password:
- **Default Username:** `admin`
- **Default Password:** `admin`

## Step 20: Change Default Password
This account should not use the default password, so set a new password.

### Step 21: Create the Target Group
Create a target group and add the instance with port `9000`. Set the health check path to `/`.

- **Target Group Name:** `sonarqube-tg`

### Step 22: Create the Internal ALB (Application Load Balancer)
Create the internal load balancer and add listeners for both HTTP (`80`) and HTTPS (`443`).

- **Load Balancer Name:** `sonarqube-alb`

### Step 23: Create the A Record in Route 53
Create an A record in Route 53 to point to the SonarQube internal load balancer.

- **Record Name:** `sonarqube.techworldwithmurali.in`

### Step 24: Access SonarQube
You can access SonarQube using the following URL:

- **URL:** https://sonarqube.techworldwithmurali.in

### Final Step: SonarQube Dashboard
Congratulations! You have successfully installed SonarQube 9.9.7. If you face any issues during installation, feel free to reach out in the comment box.
