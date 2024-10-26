# How to Install Nexus 3 on Linux Server

In this guide, we will go over how to install Nexus 3 on  Linux Server

## Prerequisites:
- Sudo privileges required to install packages.
- Minimum of 2 vCPUs and 4 GB of memory.

## Steps:

### Step 1: Install Java 17
Install Java using the command below:

```bash
sudo sudo yum install java-17-amazon-corretto-devel -y
```

Check Java installation:

```bash
sudo java -version
```

### Step 2: Download Nexus 3
Download the latest version of Nexus 3 in the `/opt` directory:

```bash
sudo wget https://download.sonatype.com/nexus/3/nexus-3.73.0-12-unix.tar.gz
```

### Step 3: Extract the Downloaded Archive
Extract the archive:

```bash
sudo tar -xvf nexus-3.73.0-12-unix.tar.gz
```

### Step 4: Rename the Nexus Folder
Rename the folder for convenience:

```bash
sudo mv nexus-3.73.0-12 nexus
```

### Step 5: Create a Nexus User
It’s not recommended to run Nexus as the root user. Create a new user for Nexus:

```bash
sudo adduser nexus
```

Check if the user is created:

```bash
sudo id nexus
```

Change the ownership of the `nexus` and `sonatype-work` directories:

```bash
sudo chown -R nexus:nexus nexus
sudo chown -R nexus:nexus sonatype-work/
```

### Step 6: Update the Nexus User in Nexus Configuration
Edit the `/opt/nexus/bin/nexus.rc` file and set the user to `nexus`:

```bash
run_as_user="nexus"
```

### Step 7: (Optional) Change Nexus Data Directory
If needed, you can change the default data directory in the `nexus.vmoptions` file under `/opt/nexus/bin/` by modifying the `-Dkaraf.data` parameter.

### Step 8: Start Nexus
Start Nexus using the command below:

```bash
sh /opt/nexus/bin/nexus start
```

### Step 9: Check Nexus Status
Check the status of Nexus:

```bash
sh /opt/nexus/bin/nexus status
```

### Step 10: Stop Nexus
Stop Nexus with the command:

```bash
sh /opt/nexus/bin/nexus stop
```

### Step 11: Restart Nexus
Restart Nexus with:

```bash
sh /opt/nexus/bin/nexus restart
```

### Step 12: Set Up Nexus as a Service
Create the `nexus.service` file in `/etc/systemd/system/`:

```bash
sudo vim /etc/systemd/system/nexus.service
```

Add the following content to the file:

```ini
[Unit]
Description=Nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
```

### Step 13: Enable Nexus Service
Enable the service:

```bash
sudo systemctl enable nexus
```

### Step 14: Start Nexus Service
Start the Nexus service:

```bash
sudo systemctl start nexus
```

### Step 15: Stop Nexus Service
Stop the Nexus service:

```bash
sudo systemctl stop nexus
```

### Step 16: Check Nexus Service Status
Check the status of the Nexus service:

```bash
sudo systemctl status nexus
```

### Step 17: Restart Nexus Service
Restart the Nexus service:

```bash
sudo systemctl restart nexus
```

### Step 18: Open Port 8081
To access Nexus, ensure port `8081` is open.For On-Premise Servers: , run:

```bash
sudo firewall-cmd --permanent --zone=public --add-port=8081/tcp
sudo firewall-cmd --reload
```

For AWS EC2 instances, configure Security Groups to allow inbound traffic on port `8081`.

### Step 19: Access Nexus GUI
Open a browser and navigate to:

```
http://your_ip_or_domain:8081
```

### Step 20: Login to Nexus
Use the default username and password:
- **Username**: `admin`
- **Password**: Found in `/opt/sonatype-work/nexus3/admin.password`

```bash
cat /opt/sonatype-work/nexus3/admin.password
```

### Step 21: Reset Default Password
After the first login, reset the default password as prompted and disable anonymous access if needed.


### Step 22: Create the Target Group
Create a target group and add the instance with port `8081`. Set the health check path to `/`.

- **Target Group Name:** `nexus-tg`

### Step 23: Create the Internal ALB (Application Load Balancer)
Create the internal load balancer and add listeners for both HTTP (`80`) and HTTPS (`443`).

- **Load Balancer Name:** `nexus-alb`

### Step 24: Create the A Record in Route 53
Create an A record in Route 53 to point to the Nexus internal load balancer.

- **Record Name:** `nexus.techworldwithmurali.in`

### Step 25: Access Jenkins
You can access Nexus  using the following URL:

- **URL:** https://nexus.techworldwithmurali.in


## Conclusion
Congratulations! You have successfully installed Nexus 3. If you encounter any issues, feel free to reach out in the comments.
