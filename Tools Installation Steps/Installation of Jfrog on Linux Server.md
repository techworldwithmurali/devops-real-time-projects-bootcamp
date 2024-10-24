# Installing JFrog Artifactory OSS on Linxu Server

Follow these steps to install JFrog Artifactory OSS:

## Step 1: Add JFrog Artifactory Repository

Run the following command to download the JFrog Artifactory repository configuration file:

```bash
wget https://releases.jfrog.io/artifactory/artifactory-rpms/artifactory-rpms.repo -O jfrog-artifactory-rpms.repo
```

## Step 2: Move the Repository File

Move the downloaded repository file to the YUM repository directory:

```bash
sudo mv jfrog-artifactory-rpms.repo /etc/yum.repos.d/
```

## Step 3: Update YUM and Install JFrog Artifactory OSS

Update the YUM package manager and install JFrog Artifactory OSS with the following command:

```bash
sudo yum update && sudo yum install jfrog-artifactory-oss
```

## Step 4: Create the Target Group

1. Create a target group.
2. Add the instance with port **8082**.
3. Set the health check path to `/api/system/health`.

**Target Group Name:** `jfrog-tg`

## Step 5: Create the Load Balancer for JFrog

1. Create the Internal load balancer.
2. Add listeners for both HTTP (**80**) and HTTPS (**443**).

**Load Balancer Name:** `jfrog-alb`

## Step 6: Create the A Record in Route 53

1. Create an A record in Route 53 to point to the JFrog Internal load balancer.

**Record Name:** `jfrog.techworldwithmurali.in`

## Step 7: Access JFrog

Access JFrog Artifactory using the following URL:

**URL:** https://jfrog.techworldwithmurali.in


## Conclusion

You have successfully installed JFrog Artifactory OSS on your CentOS or Amazon Linux instance. You can now start and configure Artifactory as needed.
