+ <b>Author: Moole Muralidhara Reddy</b></br>
+ <b>Email:</b> techworldwithmurali@gmail.com</br>
+ <b>Website:</b> https://techworldwithmurali.com </br>
+ <b>Youtube Channel:</b> Tech World With Murali</br>
+ <b>Description:</b> Below are the steps outlined for Jenkins Freestyle Job -Managing AWS Infrastructure with Terraform.</br>

## Jenkins Freestyle Job - Managing AWS Infrastructure with Terraform

### Prerequisites:
+ Jenkins is installed
+ Terraform is installed
+ AWS cli is installed
+ Github token generate

1. **Create a New Freestyle Job**:
   - Log in to Jenkins.
   - Click **"New Item"** and select **"Freestyle Project"**.
   - Name the job and click **OK**.
   - Job Name: **terraform-aws-infrastructure-freestyle**
2. **Add Parameters**:
   - Go to **"This project is parameterized"** under **General**.
   - Add the following parameters:
     - **Choice Parameter**:
       - Name: `ACTION`
       - Choices: `plan`, `apply`, `destroy`
       - Description: Terraform action to execute.
     - **String Parameter**:
       - Name: `BRANCH`
       - Default Value: `main`
       - Description: Git branch to use for Terraform configurations.

3. **Source Code Management**:
   - Select **"Git"**.
   - Enter the repository URL: `https://github.com/techworldwithmurali/terraform-example.git`.
   - Under **Branches to build**, use the parameter `${BRANCH}` (you need to type it manually).

4. **Build Environment**:
   - Ensure the necessary Terraform and AWS CLI tools are installed on the Jenkins agent.

5. **Build Steps**:
   - Add a **Shell Execute** build step:
     ```bash
     echo "Cloning branch: ${BRANCH}"
     echo "Running Terraform action: ${ACTION}"

     # Define variables
     TERRAFORM_DIR="infra/ec2"

     # Change to Terraform directory
     cd $TERRAFORM_DIR

     # Initialize Terraform
     terraform init

     # Execute Terraform action
     case "${ACTION}" in
         plan)
             terraform plan -no-color
             ;;
         apply)
             terraform apply -no-color --auto-approve
             ;;
         destroy)
             terraform destroy -no-color --auto-approve
             ;;
         *)
             echo "Unsupported action: ${ACTION}"
             exit 1
             ;;
     esac
     ```

6. Verify whether infrastructure is created or not in AWS console.

#### Congratulations! You have successfully created the AWS infrastructure using Terraform with a Jenkins Freestyle job



---

### Workflow Summary
- **Job Parameters**:
  - The user selects `ACTION` (e.g., `plan`, `apply`, `destroy`) and specifies the branch (`BRANCH`).
- **Clone Repository**:
  - Jenkins fetches the branch specified in the `${BRANCH}` parameter.
- **Terraform Commands**:
  - Executes the appropriate Terraform command (`plan`, `apply`, or `destroy`) in the `infra/ec2` directory.
