## Integrating AWS RDS PostgreSQL with SonarQube

SonarQube supports specific versions of PostgreSQL for its database backend. As of the latest SonarQube documentation, it generally supports the following PostgreSQL versions:

1. **PostgreSQL 11**
2. **PostgreSQL 12**
3. **PostgreSQL 13**
4. **PostgreSQL 14**
5. **PostgreSQL 15**

### Notes:
- It's always best to refer to the official [SonarQube documentation](https://docs.sonarsource.com/sonarqube/9.9/requirements/prerequisites-and-overview/) for the most up-to-date information regarding supported database versions, as this may change with new releases.
- Ensure that you're using a compatible version to avoid any issues with performance or features.

### Step 1: Create the AWS RDS PostgreSQL 14 Instance

**Note:** Create the subnet group first.
Name: PostgreSQL-data-subnets

1. **Log in to AWS Management Console**.
2. Navigate to **RDS**.
3. Click on **Create database**.
4. Select **Standard Create**.
5. Choose **PostgreSQL** as the database engine.
6. Configure the database settings:
   - **DB instance class**: Choose an instance type based on your needs.
   - **Storage**: Set the allocated storage.
   - **DB instance identifier**: Give your DB a unique name.
   - **Master username**: Set a username for the master user.
   - **Master password**: Set a strong password.
7. Configure **VPC**, **Subnet**, and **Security Groups** to allow access to the RDS instance from your SonarQube server.
8. Click on **Create database** to launch the RDS instance.

### Step 2: Install the PostgreSQL Client on Amazon Linux 2023

SSH into your Amazon Linux 2023 instance and run the following commands:

```bash
sudo dnf install postgresql15 -y
```

### Step 3: Connect to the RDS PostgreSQL Cluster

Use the PostgreSQL client to connect to your RDS instance. Replace `<endpoint>`, `<username>`, and `<database>` with your values:

```bash
psql -h <endpoint> -U <username> -d postgres
psql -h infra-sonaruqbe.cr6o2yyc8wq0.us-east-1.rds.amazonaws.com -U postgress
```

You’ll be prompted for your password. Once logged in, you can run SQL commands.

### Step 4: Create the Database and User, and Grant Permissions

Once connected to the PostgreSQL instance, run the following SQL commands:

```sql
-- Create a new database for SonarQube
CREATE DATABASE sonarqube;

-- Create a new user
CREATE USER sonaruser WITH PASSWORD 'p7tl6P7Jnpvi3l5';

-- Grant permissions
GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonaruser;

```

### Step 5: Stop SonarQube

If SonarQube is running, stop it. This can usually be done with:

```bash
sudo systemctl stop sonarqube
```

### Step 6: Add the SonarQube Database Details

Edit the SonarQube configuration file to include your RDS PostgreSQL database details. Open `sonar.properties`:

```bash
sudo vi /opt/sonarqube/conf/sonar.properties
```

Find and update the following lines:

```properties
# Database settings
sonar.jdbc.url=jdbc:postgresql://<endpoint>:5432/sonarqube
sonar.jdbc.user=sonaruser
sonar.jdbc.password=p7tl6P7Jnpvi3l5
```
Uncomment the Java Options in sonar.properties
Open the sonar.properties file and uncomment the following line:
```properties

sonar.ce.javaOpts=-Xmx512m -Xms128m -XX:+HeapDumpOnOutOfMemoryError
```

### Step 7: Restart SonarQube

After saving the changes, restart SonarQube:

```bash
sudo systemctl start sonarqube
```

### Step 8: Verify SonarQube Using the RDS Database

1. **Access SonarQube GUI**: Open your web browser and go to:
   ```
   http://<your_sonarqube_server>:9000
   ```

2. **Check the Database**: Log in to your RDS PostgreSQL instance again and run the following command to verify that the SonarQube tables have been created:

```sql
\c sonarqube
\dt
```

You should see tables that are used by SonarQube.

### Final Step: SonarQube Dashboard
Congratulations! You have successfully installed and configured SonarQube using an Amazon RDS PostgreSQL database. If you face any issues during installation, feel free to reach out in the comment box.
