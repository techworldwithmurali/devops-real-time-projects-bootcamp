# Installation of Tomcat  on Linux Server.

In this session, we are going to discuss the Installation of Tomcat  on Linux Server.

#### Prerequisites
- You must be logged in via SSH as a sudo or root user to install the packages.

#### Step 1:  Install Java 17
```bash
[root@ip-172-31-89-37 ~]# sudo yum install java-17-amazon-corretto-devel -y
```

#### Step 1.1: Check Java Installation
Check whether Java is installed using the following command: 
```bash
[root@ip-172-31-89-37 ~]# sudo java -version
```

#### Step 2: Download Tomcat 9
Go to the Tomcat official page and download the Tomcat 9.0.96 binary tar file in the `/opt` directory.

- **URL:** [Apache Tomcat 9.0.96](https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.96/bin/)
```bash
[root@ip-172-31-89-37 ~]# cd /opt/
[root@ip-172-31-89-37 opt]# wget https://archive.apache.org/dist/tomcat/tomcat-7/v9.0.96/bin/apache-tomcat-9.0.96.tar.gz
```
#### Step 3: Untar Tomcat
Untar the Tomcat using the following command:
```bash
[root@ip-172-31-89-37 opt]# sudo tar -xvf apache-tomcat-9.0.96.tar.gz
```
> **Note:** 
> - `x` = extract 
> - `v` = verbose
> - `f` = file 

#### Step 4: Rename Tomcat Directory
Rename the Tomcat directory using the following command:
```bash
[root@ip-172-31-89-37 opt]# sudo mv apache-tomcat-9.0.96 tomcat
```

#### Step 5: Create Tomcat User
As a good security practice, it is not recommended to run Tomcat with root privileges. Create a new user named `tomcat` to run the Tomcat service.

##### Step 5.1: Create Tomcat User
```bash
[root@ip-172-31-89-37 opt]# sudo useradd tomcat
```

#### Step 5.2: Change Ownership of Tomcat Directory
```bash
[root@ip-172-31-89-37 opt]# sudo chown -R tomcat:tomcat tomcat/
```

#### Step 6: Start Tomcat
To start Tomcat, use the following command:
```bash
[root@ip-172-31-89-37 opt]# sudo sh /opt/tomcat/bin/startup.sh
```

#### Step 7: Stop Tomcat
To stop Tomcat, use the following command:
```bash
[root@ip-172-31-89-37 opt]# sudo sh /opt/tomcat/bin/shutdown.sh
```

#### Step 8: Setup Tomcat as a Service
Create the `tomcat.service` file under the `/etc/systemd/system/` directory:
```bash
[root@ip-172-31-89-37 opt]# sudo vim /etc/systemd/system/tomcat.service
```
#### Contents of `tomcat.service` File
```ini
[Unit]
Description=Tomcat 9.0.96 container
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
```

#### Step 9: Enable Tomcat Service
```bash
[root@ip-172-31-89-37 opt]# sudo systemctl enable tomcat
```

#### Step 10: Start Tomcat Service
```bash
[root@ip-172-31-89-37 opt]# sudo systemctl start tomcat
```
**OR**
```bash
[root@ip-172-31-89-37 opt]# sudo service tomcat start
```

#### Step 11: Stop Tomcat Service
```bash
[root@ip-172-31-89-37 opt]# sudo systemctl stop tomcat
```
**OR**
```bash
[root@ip-172-31-89-37 opt]# sudo service tomcat stop
```

#### Step 12: Check Tomcat Service Status
```bash
[root@ip-172-31-89-37 opt]# sudo systemctl status tomcat
```
**OR**
```bash
[root@ip-172-31-89-37 opt]# sudo service tomcat status
```

#### Step 13: Restart Tomcat Service
```bash
[root@ip-172-31-89-37 opt]# sudo systemctl restart tomcat
```
**OR**
```bash
[root@ip-172-31-89-37 opt]# sudo service tomcat restart
```

#### Step 14: Enable Port 8080
To access the Tomcat GUI, first enable the `8080` port number. 

#### For On-Premise Server
```bash
[root@ip-172-31-89-37 ~]# sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
[root@ip-172-31-89-37 ~]# sudo firewall-cmd --reload
```

#### For AWS EC2 Instance
Open the Inbound rules for port `8080` in Security Groups for the server.

> **Note:** If port `8080` is not enabled, you can't access the Tomcat GUI.

#### Step 15: Access the Tomcat GUI
Open any browser and type your domain or IP address followed by port `8080`:
```
http://your_ip_or_domain:8080
```
**Example:** 
```
http://54.175.240.24:8080
```

#### Step 16: Configure the Management Interface
Add users and roles in `tomcat-users.xml` under the `/opt/tomcat/conf/` directory.
```bash
[root@ip-172-31-89-37 opt]# sudo vim /opt/tomcat/conf/tomcat-users.xml
```

#### Add the Following Users and Roles
```xml
<tomcat-users>
    <role rolename="manager-gui" />
    <role rolename="manager-status" />
    <role rolename="manager-script" />
    <role rolename="manager-jmx" />
    <role rolename="admin-gui" />
    <role rolename="admin-script" />
    
    <user username="tomcat" password="tomcat" roles="manager-gui, admin-gui, manager-status, manager-script, manager-jmx"/>
</tomcat-users>
```

#### Step 17: Restart Tomcat Service
After updating the users and roles, restart the Tomcat service. The new user will now have access to the web interfaces (manager-gui and admin-gui).

#### Access Tomcat Web Application Manager
Navigate to:
```
http://your_ip:8080/manager/html
```
Once prompted, enter the username and password. You can manage your applications from here.


#### Step 18: Create the Target Group
Create a target group and add the instance with port `8080`. Set the health check path to `/`.

- **Target Group Name:** `tomcat-tg`

#### Step 19: Create the Internal ALB (Application Load Balancer)
Create the internal load balancer and add listeners for both HTTP (`80`) and HTTPS (`443`).

- **Load Balancer Name:** `tomcat-alb`

#### Step 20: Create the A Record in Route 53
Create an A record in Route 53 to point to the Tomcat internal load balancer.

- **Record Name:** `tomcat.techworldwithmurali.in`

#### Step 21: Access Jenkins
Access Jenkins using the following URL:
- **URL:** https://tomcat.techworldwithmurali.in
#### Conclusion
Congratulations! You have successfully installed Tomcat 9. If you face any issues during the installation, feel free to reach out in the comment box.
