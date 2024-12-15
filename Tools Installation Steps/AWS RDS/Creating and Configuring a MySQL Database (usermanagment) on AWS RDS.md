step-by-step guide to create an AWS RDS MySQL instance with your specific configurations:

### Prerequisites:
- Make sure you have an active AWS account.
- Ensure you have the necessary IAM permissions to create RDS instances and modify VPC/security groups.
  
### Steps to Create AWS RDS MySQL Instance:

#### Step 1: Sign in to AWS Management Console
1. Go to the [AWS Management Console](https://aws.amazon.com/console/).
2. Sign in using your AWS account credentials.

#### Step 2: Navigate to RDS Service
1. In the AWS Management Console, search for **RDS** in the search bar and select **RDS** to go to the RDS dashboard.

#### Step 3: Create a New Database
1. In the RDS dashboard, click on **Databases** in the left sidebar.
2. Click the **Create database** button to start the creation process.

#### Step 4: Choose Database Engine
1. On the "Choose a database creation method" page, select **Standard Create**.
2. In the "Engine options," select **MySQL**.
3. Choose the version **8.0.34** of MySQL (ensure the version matches your requirement).
4. Click **Next**.

#### Step 5: Configure the Database Instance

##### **Database Settings:**
1. **DB instance identifier:** Enter `rds-mysql-dev` (as the DB instance name).
2. **Master username:** Enter `admin`.
3. **Master password:** Enter the password `oAdtzSkyZ7geWJRqqio` (ensure it meets the required password complexity).
4. **Database name:** Enter **usermanagment** (this will create the database by default).

##### **DB Instance Class:**
1. Choose the appropriate instance class (e.g., `db.t3.micro` for testing purposes or `db.m5.large` for production).

##### **Storage:**
1. **Storage type:** Choose **General Purpose (SSD)**.
2. Set the **Allocated storage** (e.g., 20 GB).
3. Enable **Storage autoscaling** if required, which allows automatic expansion of storage as needed.

#### Step 6: Configure Connectivity

##### **VPC Configuration:**
1. **VPC:** Select **infra VPC** (make sure it’s the correct VPC that you want to use).
2. **Subnet group:** Select **mysql-rds-dev-subnet-group** from the dropdown list.
3. **Public access:** Choose **Yes** if you need the RDS instance to be publicly accessible (for development or testing). If this is for production, select **No** for better security.
4. **VPC Security Groups:** Select **mysql-rds-dev-sg** as the security group.
   - Make sure the security group allows inbound access on the port 3306 for MySQL connections.

#### Step 7: Configure Additional Settings (Optional)

1. **DB parameter group:** Select **mysql-rds-dev-parameter-group** if you have a custom parameter group for your MySQL instance, or leave the default setting if no customization is required.
2. **Backup:** Set the **Backup retention period** (e.g., 7 days).
3. **Monitoring:** Enable **Enhanced monitoring** for detailed metrics, if needed.
4. **Encryption:** Choose **Encryption** if required for compliance or security.

#### Step 8: Review and Create
1. Review all your configurations to ensure everything is correct.
2. Click **Create database** to launch your RDS MySQL instance.

#### Step 9: Wait for the Database to Become Available
1. Once the creation process starts, you will see the status of the database change to **creating**. Wait for the instance to become **Available**.
2. Once it is available, the status will change to **Available** in the RDS dashboard.

#### Step 10: Create a CNAME in Route 53 for the RDS Instance

1. Navigate to the **Route 53** service in the AWS Management Console.  
2. Select the hosted zone for your domain.  
3. Click on **Create Record** and choose **CNAME** as the record type.  
4. Enter the desired subdomain (e.g., `rds-dev.techworldwithmurali.in`) and set the value to the **RDS endpoint** (e.g., `rds-mysql-dev.cpigug8q8as5.us-east-1.rds.amazonaws.com`).   
5. Save the record.  

This will allow you to connect to the RDS instance using the CNAME instead of the endpoint.

#### Step 11: Connect to the RDS PostgreSQL Cluster and Verify the Database
**Set Up a New Connection in MySQL Workbench**
1. In the **MySQL Workbench** window, click on the **"+" icon** next to **MySQL Connections** to set up a new connection.
2. In the **Set up a New Connection** window:
   - **Connection Name**: Choose a name for your connection (e.g., `rds-mysql-dev`).
   - **Connection Method**: Select **Standard (TCP/IP)**.
   - **Hostname**: Paste the **Endpoint** of your RDS instance that you copied earlier.
   - **Port**: Enter the **Port** (default is `3306`).
   - **Username**: Enter `admin` (the master username you set during RDS creation).
   - **Password**: Click on **Store in Vault...** and enter the password `oAdtzSkyZ7geWJRqqio`.

3. Click **Test Connection** to ensure MySQL Workbench can connect to the RDS instance. If the connection is successful, click **OK**.

#### Step 12: Connect to the Database Instance
1. After setting up the connection, click on the new connection (e.g., `rds-mysql-dev`) in the **MySQL Connections** section to open the connection.

#### Step 13: Verify the Database Creation
1. Once connected, the **SQL Editor** will open.
2. To verify that the **usermanagment** database was created, run the following SQL command:

   ```sql
   SHOW DATABASES;
   ```

3. Check the result. You should see **usermanagment** listed among the databases.
