## Installing Jfrog artifactory on Kubernetes Using Helm Chart

To install artifactory on Kubernetes using Helm, follow these steps:

## Prerequisites

Before you begin, ensure the following tools and resources are available:

- **Install Helm**: Ensure Helm is installed on your system.  
- **Install kubectl**: Ensure kubectl is installed for interacting with Kubernetes clusters.  
- **Install AWS CLI**: Ensure AWS CLI is installed for AWS-related operations.  
- **Create AWS EKS Cluster**: Ensure an EKS cluster is already created.  
- **AWS RDS PostgreSQL**: Ensure an AWS RDS PostgreSQL instance is created.  
- **AWS ALB Ingress Controller**: Deployed to the cluster.  
- **ExternalDNS**: Configured for managing DNS entries.

## Step-by-Step Instructions

### Step 0: Create the artifactory Namespace
```bash
kubectl create ns artifactory
```

### Step 1: Add JFrog Helm Repository
Before installing JFrog Helm charts, you need to add the JFrog Helm repository to your Helm client.
```bash
helm repo add jfrog https://charts.jfrog.io
helm repo update
```

- Official GitHub link: [JFrog Helm Charts](https://github.com/jfrog/charts/tree/387d7a1aa890bb65fb42a7d5b2c65cae0b7dded1/stable/artifactory)
- Office Website : https://jfrog.com/help/r/jfrog-installation-setup-documentation/artifactory-ha-installation

### Step 2: Install the Chart
To install the chart with the release name `artifactory`, run the following:
```bash
helm upgrade --install jfrog/artifactory -n artifactory
```

**Note**:  
1. This will install the latest Artifactory Pro version.  
2. NGINX and PostgreSQL will be installed by default, but we will use AWS RDS PostgreSQL instead of installing PostgreSQL in Kubernetes.  
3. This will create StatefulSets, services, configmaps, and secrets.  
4. It’s recommended to install a slightly older version of Artifactory rather than the latest one. In this example, we will install version 7.59.23 instead of the latest version (7.98.9).

### Step 3: Check Available Versions of the Chart
To see all available versions of a specific chart, use:
```bash
helm search repo jfrog/artifactory --versions
```

### Step 4: Update `values.yaml` for Required Artifactory Version
Modify the `values.yaml` file to specify the version of Artifactory you want to install:
```yaml
artifactory:
  image:
    registry: docker.bintray.io
    repository: jfrog/artifactory-oss
    tag: 7.59.23
    pullPolicy: IfNotPresent
```

Then, upgrade the installation:
```bash
helm upgrade --install -f values.yaml artifactory jfrog/artifactory  -n artifactory --version 107.59.23
```

### Step 5: Disable Default NGINX and PostgreSQL in `values.yaml`
If you don't need NGINX and PostgreSQL, disable them in the `values.yaml` file:
```yaml
nginx:
  enabled: false

postgresql:
  enabled: false
```

Then, run the upgrade command again:
```bash
helm upgrade --install -f values.yaml artifactory jfrog/artifactory  -n artifactory --version 107.59.23
```

### Step 6: Disable Persistent Volume for PostgreSQL
If you encounter issues related to PVC while using AWS RDS PostgreSQL, disable the persistence volume in the `values.yaml`:
```yaml
artifactory:
  persistence:
    enabled: false
```

Run the upgrade command:
```bash
helm upgrade --install -f values.yaml artifactory jfrog/artifactory  -n artifactory --version 107.59.23
```

### Step 7: Add Database Configuration in `values.yaml`
Add the external PostgreSQL database configuration to the `values.yaml`:
```yaml
database:
  type: postgresql
  secrets: {}  # Empty database secrets as it's managed externally
  driver: org.postgresql.Driver
  unifiedSecretInstallation: false
  url: "jdbc:postgresql://sonarqube.ctilyyfujcpu.us-east-1.rds.amazonaws.com:5432/artifactory"  # Your external DB URL
  user: "postgres"
  password: "mPqoZDTuKsGPYCAru5"  # Ensure this is stored securely, potentially in a secret manager
```

Run the upgrade command:
```bash
helm upgrade --install -f values.yaml artifactory jfrog/artifactory  -n artifactory --version 107.59.23
```

### Important Notes

For **production-grade installations**, it is **strongly recommended** to use a custom **master key**. Using the default master key during the initial setup will make it extremely difficult to change at a later stage. 

---

#### Step 8: Steps to Create and Use a Unique Master Key and Join Key

1. **Generate a Unique Master Key**  
   Artifactory requires a unique master key to function. To create one, use the following command:  

   ```bash
   openssl rand -hex 32
   ```

2.  **Generate a Unique Join Key**

To generate a secure join key, execute the following command:  

```bash
openssl rand -hex 32
```

2. **Add  the Master Key and join key in values.yaml unnder artifactory
```bash
masterKey: "89c8b7fb44344139d35b58ca73820e0dad682e9d894682878e5febcd91dff2e3"
joinKey: "15ae6f00c0d887ed3f57658c73f4025895f323a12332fa006a1f8551c3d58d88"
```

### Step 9: Update Service Type in `values.yaml`
To change the service type to NodePort, modify `values.yaml`:
```yaml
service:
  type: NodePort
```

Run the upgrade command:
```bash
helm upgrade --install -f values.yaml artifactory jfrog/artifactory  -n artifactory --version 107.59.23
```

### Step 10: Access Artifactory Using NodePort
Once the installation is complete, access Artifactory using NodePort:
```
http://node-ip:node-port
```

### Step 11: Create Ingress Resource for DNS Access
Create the ingress resource to access Artifactory via DNS:
```yaml
internal:
  enabled: true
  className: "alb"
  annotations:
    alb.ingress.kubernetes.io/scheme: internal
    alb.ingress.kubernetes.io/tags: app=techworldwithmurali,Team=DevOps
    alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:us-east-1:266735810449:certificate/8a7cbcb1-774c-463f-ab3e-476437028686
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS": 443}]'
    alb.ingress.kubernetes.io/ssl-redirect: '443'
    alb.ingress.kubernetes.io/security-groups: sg-026c5ab74985fa179
  hosts:
    - hostname: jfrog.techworldwithmurali.in
      service: artifactory
      port: 8082
```
### Step 12: Apply the ingress
```yaml
kubectl apply -f ingress.yaml
```
### Step 13: Access Artifactory Using DNS Name
Once the ingress resource is created, you can access Artifactory at:
```
https://jfrog.techworldwithmurali.in
```
**Congratulations!** You have successfully installed JFrog using Helm.
