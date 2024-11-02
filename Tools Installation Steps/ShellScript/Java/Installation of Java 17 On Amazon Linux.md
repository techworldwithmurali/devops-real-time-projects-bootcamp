###  Installation of Java 17 On Amazon Linux

##### Note: For the latest releases and more information, visit the official  website:
**Official Webiste:** https://docs.aws.amazon.com/corretto/latest/corretto-17-ug/amazon-linux-install.html

```bash
#!/bin/bash

# Step 1: Install Java 17 on Amazon Linux 2023
echo "Installing Java 17..."
sudo yum install -y java-17-amazon-corretto-devel

# Step 2: Check the Java version
echo "Checking Java version..."
java --version
```

Save this script as `install_java17.sh`, make it executable, and run it:

```bash
chmod +x install_java17.sh
./install_java17.sh
```
