+ <b>Author: Moole Muralidhara Reddy</b></br>
+ <b>Email:</b> techworldwithmurali@gmail.com</br>
+ <b>Website:</b> https://techworldwithmurali.com </br>
+ <b>Youtube Channel:</b> Tech World With Murali</br>
+ <b>Description:</b> Below are the steps outlined for Jenkins Pipeline Job - Managing AWS Infrastructure with Terraform.</br>

## Jenkins Pipeline Job - Managing AWS Infrastructure with Terraform

### Prerequisites:
+ Jenkins is installed
+ Terraform is installed
+ AWS CLI is installed
+ GitHub credentials configured in Jenkins

### Step 1: Install and configure the Jenkins plugins
 + Git plugin

### Step 2: Create the Jenkins Pipeline job
```xml
Job Name: terraform-aws-infrastructure-pipeline
```

### Step 3: Configure the Git repository
```xml
GitHub URL: https://github.com/techworldwithmurali/terraform-example.git
Branch: main
Credentials: github-cred
```

### Step 4: Write the Jenkinsfile
  + ### Step 4.1: Clone the repository 
```xml
stage('Clone the Repository') {
            steps {
                git branch: 'main', credentialsId: 'github-cred', url: 'https://github.com/techworldwithmurali/terraform-example.git'
            }
        }
```
  + ### Step 4.2: Initialize Terraform
```xml
stage('Terraform Init') {
            steps {
                dir('infra/ec2') {
                    sh 'terraform init'
                }
            }
        }
```

  + ### Step 4.3: Run Terraform Plan, Apply, or Destroy
```xml
stage('Terraform Plan or Apply or Destroy') {
            steps {
                script {
                    if (params.ACTION == 'plan') {
                        echo 'Executing Terraform plan...'
                        dir('infra/ec2') {
                            sh 'terraform plan -no-color'
                        }
                    } else if (params.ACTION == 'apply') {
                        echo 'Executing Terraform apply...'
                        dir('infra/ec2') {
                            sh 'terraform apply -no-color --auto-approve'
                        }
                    } else if (params.ACTION == 'destroy') {
                        echo 'Executing Terraform destroy...'
                        dir('infra/ec2') {
                            sh 'terraform destroy -no-color --auto-approve'
                        }
                    } else {
                        error("Unsupported ACTION: ${params.ACTION}")
                    }
                }
            }
        }
```

### Step 5: Verify whether the infrastructure has been created in the AWS Console.

#### Congratulations. You have successfully created, applied, or destroyed the AWS infrastructure using Jenkins Pipeline with Terraform.
