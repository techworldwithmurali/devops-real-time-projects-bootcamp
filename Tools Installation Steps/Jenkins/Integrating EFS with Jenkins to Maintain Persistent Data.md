### Integrating EFS with Jenkins to Maintain Persistent Data

1. **Create EFS**: Ensure your EFS file system is created and configured in the AWS Management Console.

2. **Mount EFS**: Use the provided `mount` command to attach the EFS to your Jenkins server:
   ```bash
   sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0bcbf91655f493213.efs.us-east-1.amazonaws.com:/ /var/lib/jenkins
   ```

3. **Verify Mount**: Run `df -h` to confirm the EFS is successfully mounted.

4. **Persistent Mount via `/etc/fstab`**: Edit the `/etc/fstab` file to automate mounting on reboot:
   ```bash
   fs-0bcbf91655f493213.efs.us-east-1.amazonaws.com:/ /var/lib/jenkins  nfs4 defaults,nofail,_netdev 0 0
   ```

5. **Reboot for Testing**: Restart the server to check if the EFS mounts automatically.
