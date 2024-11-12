### Install SonarScanner on a Linux server

To install SonarScanner on a Linux system and set it up in the environment variables, follow these steps:

1. **Navigate to the `/opt` directory:**
   ```bash
   cd /opt/
   ```

2. **Download the SonarScanner zip file:**
   ```bash
   wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.2.1.4610-linux-x64.zip
   ```
Reference link: https://docs.sonarsource.com/sonarqube/10.6/analyzing-source-code/scanners/sonarscanner/

3. **Unzip the downloaded file:**
   ```bash
   unzip sonar-scanner-cli-6.2.1.4610-linux-x64.zip
   ```

4. **List the files in the `/opt` directory to verify the extracted files:**
   ```bash
   ll
   ```

5. **Rename the extracted folder to `sonar-scanner`:**
   ```bash
   mv sonar-scanner-6.2.1.4610-linux-x64/ sonar-scanner
   ```

6. **Add the SonarScanner binary directory to the system `PATH` by editing `/etc/profile`:**
   ```bash
   echo 'export PATH=$PATH:/opt/sonar-scanner/bin' | sudo tee -a /etc/profile
   ```

7. **Apply the changes to the profile:**
   ```bash
   source /etc/profile
   ```

Now SonarScanner should be available globally on the system, and you can verify its installation with:

```bash
sonar-scanner --version
```
