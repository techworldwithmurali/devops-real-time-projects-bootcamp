### **Migration Steps**  

1. **Assess Existing Infrastructure**  
   - Review the current on-premises setup.  
   - Identify components that need migration (applications, databases, networking, security, dependencies).  
   - Perform application dependency mapping.  
   - Define the migration strategy (Rehost, Refactor, Rearchitect, Rebuild, Replace).  

2. **Set Up Cloud Networking**  
   - Design and configure VPC, subnets (public/private), route tables, NAT Gateway, Internet Gateway.  
   - Ensure proper security groups and NACLs are set up.  
   - Set up IAM roles and policies for access control.  

3. **Set Up Site-to-Site VPN / Direct Connect**  
   - Establish secure connectivity between on-premises and the cloud environment.  
   - Test latency and bandwidth to ensure performance meets requirements.  

4. **Provision Cloud Infrastructure (EKS, EC2, RDS, etc.)**  
   - Deploy required infrastructure like EKS, RDS, ECS, or EC2.  
   - Set up required storage (EFS, S3, FSx).  
   - Configure monitoring (CloudWatch, Prometheus, Grafana).  

5. **Migrate Databases from On-Premises to Cloud**  
   - Choose a migration strategy (DMS, snapshot restore, backup-restore, live replication).  
   - Test data consistency and performance.  

6. **Deploy the Application in Lower Environments (DEV, QA, UAT, etc.)**  
   - Deploy application workloads on EKS or other compute services.  
   - Configure autoscaling, load balancing, service discovery.  

7. **Validate the Application in Lower Environments**  
   - Perform functional, performance, and security testing.  
   - Ensure application components are communicating correctly.  

8. **Prepare for Production Deployment**  
   - Finalize migration runbook and rollback strategy.  
   - Get approvals for production deployment.  
   - Ensure monitoring and logging are in place.  

9. **Deploy the Application to Production (EKS, EC2, ECS, etc.)**  
   - Deploy the production application in the cloud environment.  
   - Ensure autoscaling, load balancing, and failover mechanisms are configured.  

10. **Validate the Application in Production**  
   - Conduct sanity testing to verify application functionality.  
   - Ensure all integrations, logging, and monitoring are functioning correctly.  

11. **Initiate DNS Cutover (Raise ICR for DNS Change)**  
   - Update Route 53 or other DNS service to point traffic to the cloud environment.  
   - Perform controlled traffic switching (e.g., weighted routing, blue-green deployment).  

12. **Perform Post-Migration Validation and Testing**  
   - Validate the application with end-to-end user testing.  
   - Monitor logs, performance metrics, and error rates.  

13. **Send Migration Completion Notification**  
   - Inform stakeholders about successful migration.  

14. **Monitor the Application for a Few Days**  
   - Closely monitor performance, user feedback, and application stability.  
   - Use CloudWatch, X-Ray, or third-party tools for observability.  

15. **Rollback Plan (If Needed)**  
   - If any major issues occur, revert DNS changes to point back to on-premises.  
   - Ensure rollback strategy is well-tested in pre-production.  
