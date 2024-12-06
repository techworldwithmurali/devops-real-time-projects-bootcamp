### Installing SonarQube on Kubernetes Using a Helm Chart

To install SonarQube on Kubernetes using Helm, follow these steps:

### Prerequisites

Before you begin, ensure the following tools and resources are available:

- **Install Helm**: Ensure Helm is installed on your system.
- **Install kubectl**: Ensure kubectl is installed for interacting with Kubernetes clusters.
- **Install AWS CLI**: Ensure AWS CLI is installed for AWS-related operations.
- **Create AWS EKS Cluster**: Ensure an EKS cluster is already created.
- **AWS RDS PostgreSQL**: Ensure an AWS RDS PostgreSQL instance is created.
- **AWS ALB Ingress Controller**: Deployed to the cluster.
- **ExternalDNS**: Configured for managing DNS entries.

**For more information, visit the [official Helm chart GitHub repository](https://github.com/SonarSource/helm-chart-sonarqube/tree/master).

**For more information, visit the: https://www.sonarsource.com/products/sonarqube/downloads/

---

## Step-by-Step Instructions

### Step 0: Create the SonarQube Namespace
```bash
kubectl create ns sonarqube
```

---

### Step 1: Add the SonarQube Helm Repository
Add the official Helm chart repository for SonarQube:
```bash
helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
helm repo update
```

---

### Step 2: Install SonarQube with Default Values
Deploy SonarQube using default configurations:
```bash
helm upgrade --install -f values.yaml  sonarqube sonarqube/sonarqube -n sonarqube
```
- Installs the latest SonarQube version with an embedded PostgreSQL database.
- Recommended to install a stable version like `9.9.8` rather than the latest.

---

### Step 3: Update `values.yaml` for Required SonarQube Version
Modify `values.yaml`:
```yaml
image:
  repository: sonarqube
  tag: 9.9.7-developer
  pullPolicy: IfNotPresent
```
Then, upgrade the installation:
```bash
helm upgrade --install -f values.yaml  sonarqube sonarqube/sonarqube -n sonarqube
```

---

### Step 4: Disable Embedded PostgreSQL
To use AWS RDS PostgreSQL, disable the embedded PostgreSQL:
```yaml
postgresql:
  enabled: false
```
Upgrade the installation:
```bash
helm upgrade --install -f values.yaml  sonarqube sonarqube/sonarqube -n sonarqube
```

---

### Step 5: Add Database Configuration in `values.yaml`
Configure the external PostgreSQL database:
```yaml
jdbcOverwrite:
  enabled: true
  jdbcUrl: "jdbc:postgresql://sonarqube-rds.techworldwithmurali.in:5432/sonarqube"
  jdbcUsername: "postgres"
  jdbcPassword: "mPqoZDTuKsGPYCAru5"  # Secure this using Kubernetes Secrets
```
Run the upgrade command:
```bash
helm upgrade --install -f values.yaml  sonarqube sonarqube/sonarqube -n sonarqube
```

---

### Step 6: Update Service Type
Change the service type to `NodePort` in `values.yaml`:
```yaml
service:
  type: NodePort
```
Upgrade the installation:
```bash
helm upgrade --install -f values.yaml  sonarqube sonarqube/sonarqube -n sonarqube
```

---

### Step 7: Access SonarQube Using NodePort
Access SonarQube at:
```
http://<node-ip>:<node-port>
```

---

### Step 8: Create Ingress Resource for DNS Access
Create an ingress resource for DNS access:
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
    - hostname: sonarqube.techworldwithmurali.in
      service: sonarqube-sonarqube
      port: 9000
```

---

### Step 9: Apply the Ingress
```bash
kubectl apply -f ingress.yaml
```

---

### Step 10: Access SonarQube Using DNS
Access SonarQube at:
```
https://sonarqube.techworldwithmurali.in
```

---

Congratulations! You have successfully installed SonarQube on AWS EKS using Helm.
