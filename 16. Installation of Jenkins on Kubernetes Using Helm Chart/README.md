### Installation of Jenkins on Kubernetes Using Helm Chart
***To install Jenkins on Kubernetes using Helm, follow these steps:***

### Prerequisites:
1. **Install Helm**: Ensure Helm is installed on your system.
2. **Install kubectl**: Ensure kubectl is installed for interacting with Kubernetes clusters.
3. **Install AWS CLI**: Ensure AWS CLI is installed for AWS-related operations.
4. **Create AWS EKS Cluster**: Ensure an EKS cluster is already created.
5. **EFS is created to maintain persistent data**
6. **Install the AWS EFS CSI Driver**:
   - Add the EFS CSI driver Helm repository:
     ```bash
     helm repo add aws-efs-csi-driver https://kubernetes-sigs.github.io/aws-efs-csi-driver/
     helm repo update
     ```
   - Install the AWS EFS CSI driver:
     ```bash
     helm install aws-efs-csi-driver aws-efs-csi-driver/aws-efs-csi-driver \
       --namespace kube-system \
       --set controller.serviceAccount.create=true \
       --set controller.serviceAccount.name=efs-csi-controller-sa
     ```
   - Verify if the CSI driver pods are running:
     ```bash
     kubectl get pods -n kube-system -l app=efs-csi-controller
     ```
7. **AWS ALB Ingress Controller: Deployed to the cluster.**
8. **ExternalDNS:** Configured for managing DNS entries.
### Step-by-Step Instructions:

**Official GitHub repository for the Jenkins Helm Chart.** https://github.com/jenkinsci/helm-charts/tree/main/charts/jenkins
#### Step 0: Create the Jenkins Namespace
```bash
kubectl create ns jenkins
```

#### Step 1: Create Persistent Volume (PV) for Jenkins
Create a PV that uses the AWS EFS volume (replace `fs-01299c0d9268d5364` with your actual EFS volume ID):
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: jenkins-efs-pv
spec:
  capacity:
    storage: 200Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  csi:
    driver: efs.csi.aws.com
    volumeHandle: fs-01299c0d9268d5364
```

#### Step 2: Create Persistent Volume Claim (PVC) for Jenkins
Create a PVC that claims the PV created in Step 1:
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: jenkins-pvc
  namespace: jenkins
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 100Gi
```

#### Step 3: Add Jenkins Helm Repository
Add the official Jenkins Helm chart repository:
```bash
helm repo add jenkins https://charts.jenkins.io
helm repo update
```

#### Step 4: Install Jenkins Helm Chart
Install Jenkins using Helm, after creating the `jenkins` namespace and ensuring the PVC is created:
```bash
helm upgrade --install jenkins jenkins/jenkins -n jenkins
```

#### Step 5: Resolve PVC Binding Issue
If you encounter the error:
```
Events:
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  27s   default-scheduler  0/2 nodes are available: pod has unbound immediate PersistentVolumeClaims. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.

```
Ensure that the PVC is correctly linked to the Jenkins deployment, and reattempt the Helm chart installation.

**Note:** To view the release manifest of a Helm release (i.e., the Kubernetes resources created or managed by the Helm chart), you can use the following command:
```yaml
helm get manifest <release-name> -n <namespace>
```
Example:

```yaml
helm get manifest jenkins -n jenkins
```


#### Step 6: Use Custom Jenkins Image
If you're using a custom Jenkins image, specify the image details in the `values.yaml` file:
```yaml
controller:
  image:
    registry: docker.io
    repository: jenkins/jenkins
    tag: "2.479.1"
    pullPolicy: IfNotPresent
```

#### Step 7: Use Existing PVC for Jenkins
Update `values.yaml` to use the pre-created PVC:
```yaml
persistence:
  enabled: true
  existingClaim: "jenkins-pvc"
```

#### Step 8: Resolve Permission Issues
If you encounter a permission error like:
```
cannot create /var/jenkins_home/jenkins.install.UpgradeWizard.state: Permission denied
```
Modify the `values.yaml` to allow the Jenkins container to run as root:
```yaml
controller:
  runAsUser: 0
  podSecurityContextOverride:
    runAsUser: 0
    runAsNonRoot: false
  containerSecurityContext:
    runAsUser: 0
    runAsGroup: 0
    readOnlyRootFilesystem: false
    allowPrivilegeEscalation: true
```

Then upgrade the Helm chart:
```bash
helm upgrade --install -f values.yaml jenkins jenkins/jenkins -n jenkins
```

#### Step 9: Expose Jenkins Using NodePort
To access Jenkins externally, change the service type to `NodePort`:
```yaml
controller:
  serviceType: NodePort
```
Upgrade the Helm chart to apply the changes:
```bash
helm upgrade --install -f values.yaml jenkins jenkins/jenkins -n jenkins
```
Access Jenkins at:
```
http://Node-IP:Node-Port
```

#### Step 10: Access the Jenkins Default Password
The default Jenkins admin password is stored in a secret in the Jenkins namespace. Retrieve it with:
```bash
kubectl get secret -n jenkins
```

#### Step 11: To set a custom admin password, add the admin password in the `controller` section of the `values.yaml` file:

```yaml
controller:
  admin:
    password: "Techworld@2580"
```

Reference link: https://github.com/jenkinsci/helm-charts/blob/main/charts/jenkins/templates/deprecation.yaml

Then, upgrade the Helm chart with the following command:

```bash
helm upgrade --install -f values.yaml jenkins jenkins/jenkins -n jenkins
```

### Step 12: To Access Jenkins Using DNS Name, Follow These Steps

Create the ingress resource:

```yaml
internal:
  enabled: true
  className: "alb"  # Use your ingress class name (e.g., "alb")
  annotations:
    alb.ingress.kubernetes.io/scheme: internal
    alb.ingress.kubernetes.io/tags: app=techworldwithmurali,Team=DevOps
    alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:us-east-1:266735810449:certificate/8a7cbcb1-774c-463f-ab3e-476437028686
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS": 443}]'
    alb.ingress.kubernetes.io/ssl-redirect: '443'
    alb.ingress.kubernetes.io/security-groups: sg-026c5ab74985fa179
  hosts:
    - hostname: jenkins.techworldwithmurali.in
      service: jenkins
      port: 8080
```

---

### Step 13: Access Jenkins Using DNS Name

Once the ingress resource is created, you can access Jenkins at:

```
https://jenkins.techworldwithmurali.in
``` 


Final values.yaml

```yaml
controller:
  admin:
    password: "Techworld@2580"
  image:
    registry: docker.io
    repository: jenkins/jenkins
    tag: "2.479.1"
    pullPolicy: IfNotPresent
  runAsUser: 0
  podSecurityContextOverride:
    runAsUser: 0
    runAsNonRoot: false
  containerSecurityContext:
    runAsUser: 0
    runAsGroup: 0
    readOnlyRootFilesystem: false
    allowPrivilegeEscalation: true
  serviceType: NodePort    


persistence:
  enabled: true
  existingClaim: "jenkins-pvc"

agent:
  image:
    registry: docker.io
    repository: jenkins/inbound-agent
    tag: "3273.v4cfe589b_fd83-2"
    pullPolicy: IfNotPresent
```

