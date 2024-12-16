+ <b>Author: Moole Muralidhara Reddy</b></br>
+ <b>Email:</b> techworldwithmurali@gmail.com</br>
+ <b>Website:</b> https://techworldwithmurali.com </br>
+ <b>Youtube Channel:</b> Tech World With Murali</br>
+ <b>Description:</b> Below are the steps outlined for Manual Process -  managing AWS infrastructure using Terraform.</br>

## Manual Process - Managing AWS Infrastructure with Terraform

### Prerequisites:
+ Terraform is installed
+ AWS CLI is installed
+ Git is installed
+ AWS account with necessary IAM permissions
+ AWS credentials configured

### Step 1: Clone the GitHub repository
```xml
GitHub URL: https://github.com/techworldwithmurali/terraform-example.git
Branch Name: infra
```

### Step 2: Initialize Terraform
```bash
cd infra/ec2
terraform init
```

### Step 3: Create or Modify Infrastructure using Terraform
1. **Run Terraform Plan**
   ```bash
   terraform plan
   ```
   This will display the changes Terraform will make to your infrastructure.

2. **Apply Changes with Terraform**
   ```bash
   terraform apply --auto-approve
   ```
   This will apply the changes to your infrastructure. If you want to manually approve, omit `--auto-approve`.

3. **Destroy Infrastructure (if needed)**
   ```bash
   terraform destroy --auto-approve
   ```
   Use this command to destroy your infrastructure if needed. This removes all resources managed by Terraform.

### Step 4: Verify the infrastructure
- Check your AWS Console to ensure the resources were created, modified, or deleted as per the Terraform actions.

#### Congratulations. You have successfully created AWS infrastructure using Terraform.
