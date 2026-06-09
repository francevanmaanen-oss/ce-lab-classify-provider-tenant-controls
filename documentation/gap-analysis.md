# Security Gap Analysis

## Critical Gaps (Immediate Action Required)

1. **S3 buckets not encrypted**
   - Risk: Data breach if bucket is misconfigured or accessed without authorisation
   - Priority: Critical
   - Action: Enable default encryption on all buckets via KMS

2. **EC2 guest OS not patched regularly**
   - Risk: Exploitation of known vulnerabilities on web and app servers
   - Priority: Critical
   - Action: Implement AWS Systems Manager Patch Manager for automated patching

3. **No audit logging enabled (CloudTrail)**
   - Risk: No visibility into API calls or changes made to the environment; unable to detect or investigate incidents
   - Priority: Critical
   - Action: Enable AWS CloudTrail in all regions and store logs in a dedicated S3 bucket

## High Priority Gaps

4. **Security groups need review**
   - Risk: Overly permissive rules may expose services to the internet
   - Priority: High
   - Action: Review all security groups, remove 0.0.0.0/0 rules where not required

5. **RDS encryption not enabled**
   - Risk: Database exposure if snapshots are shared or storage is accessed
   - Priority: High
   - Action: Create encrypted snapshot, restore to a new encrypted RDS instance

6. **ALB not configured for HTTPS**
   - Risk: Data in transit between users and the load balancer is unencrypted
   - Priority: High
   - Action: Upload an SSL/TLS certificate to ACM and add an HTTPS listener on port 443

7. **Data encryption in transit not enforced**
   - Risk: Plaintext communication between application tiers exposes sensitive data
   - Priority: High
   - Action: Enforce TLS between ALB and EC2, and between EC2 and RDS

## Medium Priority Gaps

8. **S3 versioning not enabled**
   - Risk: Accidental deletion or overwrite of objects with no recovery option
   - Priority: Medium
   - Action: Enable versioning on all S3 buckets

9. **IAM roles not reviewed for least privilege**
   - Risk: Overly broad permissions on EC2 instances could be exploited if compromised
   - Priority: Medium
   - Action: Audit ec2-app-role and restrict permissions to only what the application needs

10. **ALB access logging not enabled**
    - Risk: No record of incoming requests, making it difficult to detect attacks or debug issues
    - Priority: Medium
    - Action: Enable ALB access logs and store in a dedicated S3 bucket

11. **RDS backup restore not tested**
    - Risk: Backups exist but may not be recoverable in a real incident
    - Priority: Medium
    - Action: Perform a test restore of the RDS instance to verify backup integrity