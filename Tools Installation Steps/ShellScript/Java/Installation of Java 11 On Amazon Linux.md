### Installation of Java 11 On Amazon Linux

```bash
#!/bin/bash

# Step 1: Install Java 11 on Amazon Linux
echo "Installing Java 11..."
sudo yum install -y java-11-amazon-corretto-devel

# Step 2: Check the Java version
echo "Checking Java version..."
java --version
```

Save this script as `install_java11.sh`, make it executable, and run it:

```bash
chmod +x install_java11.sh
./install_java11.sh
```

This script installs Java 11 and displays the installed version.
