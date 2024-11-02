### Installation of  Helm on Windows

### Step 1: Download Helm

1. Open your web browser and navigate to the Helm releases page: [Helm Releases](https://github.com/helm/helm/releases).
2. Locate the latest version of Helm and download the Windows binary. Look for a file named `helm-vX.Y.Z-windows-amd64.zip`, where `X.Y.Z` is the version number.

### Step 2: Extract the Helm Binary

1. After the download is complete, navigate to your Downloads folder (or wherever the zip file is located).
2. Right-click the downloaded `.zip` file and select **Extract All**.
3. Choose a destination folder or leave it as the default, then click **Extract**.
4. Inside the extracted folder, you will find a file named `helm.exe`.

### Step 3: Move the Helm Binary

1. Create a directory for Helm, if you haven’t already. For example, you can create `C:\Software\helm`.
2. Move the `helm.exe` file into the `C:\Software\helm` directory.

### Step 4: Add Helm to Your PATH

1. To add the Helm binary to your system’s PATH:
   - Right-click on the **Start** menu and select **System**.
   - Click on **Advanced system settings** on the left side.
   - In the System Properties window, click the **Environment Variables** button.
   - Under **System variables**, find the **Path** variable, select it, and click **Edit**.
   - In the Edit Environment Variable window, click **New** and add `C:\Software\helm`.
   - Click **OK** to close all the dialog boxes.

### Step 5: Verify the Installation

1. Open a new Command Prompt or PowerShell window.
2. Run the following command to verify that Helm is installed correctly:
   ```bash
   helm version
   ```
3. You should see the version information for Helm, confirming that it is installed and accessible.

### Conclusion

You have successfully installed Helm on your Windows machine! You can now use it to manage your Kubernetes applications and charts.
