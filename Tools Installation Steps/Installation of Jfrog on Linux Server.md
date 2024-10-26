## Installation of Jfrog on Linux Server

## Prerequisites
- Your user must have sudo privileges to be able to install the packages.
- Minimum 2 VCPU & 4 GB Memory.
- Amazon Linux 2023 Server
- ALB and Target Group
- Route 53
- ACM
  
#### Step 1: Download JFrog Artifactory
```bash
wget https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/7.90.7/jfrog-artifactory-oss-7.90.7.tar.gz
```
Releases Link: https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/

#### Step 2: Untar the File
```bash
tar -xvzf jfrog-artifactory-oss-7.90.7.tar.gz
```

#### Step 3: Rename the Directory
```bash
sudo mv jfrog-artifactory-oss-7.90.7 /opt/artifactory
```

#### Step 4: Create the Systemd Service
```bash
sudo vim /etc/systemd/system/artifactory.service
```
Add the following content:
```ini
[Unit]
Description=Artifactory Service
After=network.target

[Service]
Type=forking
User=root
ExecStart=/opt/artifactory/app/bin/artifactory.sh start
ExecStop=/opt/artifactory/app/bin/artifactory.sh stop
ExecReload=/opt/artifactory/app/bin/artifactory.sh restart
TimeoutSec=600
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

#### Step 5: Enable the Service
```bash
sudo systemctl enable artifactory.service
```

#### Step 6: Check the Status
```bash
sudo systemctl status artifactory.service
```

#### Step 7: Start Artifactory
```bash
sudo systemctl start artifactory.service
```

#### Step 8: Configure AWS Security Groups
Make sure to allow inbound traffic on ports **8081** and **8082** in your AWS security group.

#### Step 9: Access JFrog Artifactory
Use the following URL to access Artifactory:
```
http://<IP-address>:8081
```

#### Note on PostgreSQL Integration
If you haven't integrated PostgreSQL, you may encounter a 404 error.

#### Step 10: Create AWS RDS PostgreSQL Instance
Set up an RDS PostgreSQL 14 instance in your AWS account.

#### Step 11: Install PostgreSQL Client
SSH into your Amazon Linux 2023 instance and run:
```bash
sudo dnf install postgresql15 -y
```

#### Step 12: Connect to the RDS PostgreSQL Cluster
Replace `<endpoint>`, `<username>`, and `<database>` with your actual values:
```bash
psql -h <endpoint> -U <username> -d postgres
```
Example:
```bash
psql -h jfrog.hhuikyyfujhty.us-east-1.rds.amazonaws.com -U postgres
```

#### Step 13: Create Database and User
Once logged in, run the following SQL commands:
```sql
-- Step 1: Create the 'artifactory' database with owner 'artifactoryuser'
CREATE DATABASE artifactory 
  WITH OWNER artifactoryuser
  ENCODING 'UTF8';

-- Step 2: Create a new user named 'artifactoryuser'
CREATE USER artifactoryuser 
  WITH PASSWORD 'p7tl6P7Jnpvi3l5';

-- Step 3: Grant all privileges on the 'artifactory' database to 'artifactoryuser'
GRANT ALL PRIVILEGES ON DATABASE artifactory 
  TO artifactoryuser;

-- Step 4: Exit the PostgreSQL command line
\q

```

#### Step 14: Stop Artifactory
If Artifactory is running, stop it:
```bash
sudo systemctl stop artifactory.service
```

#### Step 15: Configure PostgreSQL in Artifactory
Edit the configuration file:
```bash
sudo vim /opt/artifactory/var/etc/system.yaml
```
Add the PostgreSQL details:
```yaml
database:
  type: postgresql
  driver: org.postgresql.Driver
  url: jdbc:postgresql://<endpoint>:5432/artifactory
  username: artifactoryuser
  password: p7tl6P7Jnpvi3l5
```

#### Step 16: Start Artifactory
```bash
sudo systemctl start artifactory.service
```

#### Step 17: Access JFrog Artifactory Again
Use the following URL:
```
http://<IP-address>:8081
```

#### Step 18: Create the Target Group
Create a target group and add the instance with port `8081 and 8082`. Set the health check path to `/`.

- **Target Group Name:** `jfrog-tg`

#### Step 19: Create the Load Balancer
Create the internal load balancer and add listeners for both HTTP (`80`) and HTTPS (`443`).

- **Load Balancer Name:** `jfrog-alb`

#### Step 20: Create the A Record in Route 53
Create an A record in Route 53 to point to the SonarQube internal load balancer.

- **Record Name:** `artifactory.techworldwithmurali.in`

#### Step 21: Access Artifactory
You can access Artifactory using the following URL:

- **URL:** https://artifactory.techworldwithmurali.in
