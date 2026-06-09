# AWS Shared Responsibility Assessment Report

## Executive Summary
This report documents the security responsibilities for our three-tier application running on AWS. We identified 5 critical/high priority gaps that require immediate attention.

## Architecture Overview

- Web tier: Application Load Balancer + EC2 instances (public subnet)
- App tier: EC2 instances running Node.js (private subnet)
- Data tier: RDS PostgreSQL (private subnet)

## Service Model Classification

| Service | Model | Customer Responsibility Level |
|---------|-------|-------------------------------|
| EC2 | IaaS | High — customer manages OS, applications, and data |
| RDS | PaaS | Medium — customer manages data, configuration, and encryption |
| S3 | PaaS/SaaS | Medium — customer manages data, access policies, and encryption |
| ALB | PaaS | Low — customer configures routing and certificates only |
| Lambda | FaaS/PaaS | Low — customer manages code only |

## Responsibility Matrix

| Control | Service | AWS Responsibility | Customer Responsibility | Status |
|---------|---------|-------------------|-------------------------|--------|
| Physical data center security | All | Physical security, guards, access control | None | AWS Managed |
| Hypervisor security | EC2 | Hypervisor patching and isolation | None | AWS Managed |
| Guest OS patching | EC2 | None | Install security updates on EC2 instances | TODO |
| RDS OS patching | RDS | OS and database engine patching | None | AWS Managed |
| S3 bucket encryption | S3 | Encryption infrastructure (KMS) | Enable default encryption, manage keys | TODO |
| Network hardware security | All | Physical network devices and cabling | None | AWS Managed |
| VPC isolation | EC2, RDS, ALB | Hypervisor-level network isolation | VPC design, subnet configuration | Configured |
| Security group rules | EC2, RDS, ALB | Security group infrastructure | Define and review inbound/outbound rules | Review needed |
| Network ACLs | VPC | NACL infrastructure | Configure NACL rules per subnet | Configured |
| DDoS protection | All | AWS Shield Standard (always on) | Optionally enable Shield Advanced | Advanced not enabled |
| IAM user and role management | All | IAM infrastructure | Create roles, policies, enforce least privilege | TODO |
| EC2 instance isolation | EC2 | Hypervisor-level isolation between instances | None | AWS Managed |
| Application security (Node.js) | EC2 | None | Secure coding, dependency scanning, input validation | TODO |
| RDS database engine patching | RDS | Patching within maintenance window | Schedule maintenance window, test after update | Configured |
| RDS encryption at rest | RDS | KMS infrastructure | Enable encryption on RDS instance | TODO |
| RDS network access | RDS | Infrastructure | Place in private subnet, configure security groups | Configured |
| RDS automated backups | RDS | Backup infrastructure | Configure retention period, test restore | Test restore needed |
| S3 storage durability | S3 | 11 nines durability, redundancy | None | AWS Managed |
| S3 bucket policies | S3 | Policy enforcement infrastructure | Write and review bucket policies | Review needed |
| S3 block public access | S3 | Feature infrastructure | Enable Block Public Access on all buckets | Configured |
| S3 versioning | S3 | Versioning infrastructure | Enable versioning on buckets | Not enabled |
| ALB TLS termination | ALB | TLS infrastructure | Upload and manage certificates | TODO |
| ALB access logging | ALB | Logging infrastructure | Enable and store access logs | Not enabled |
| CloudTrail audit logging | All | CloudTrail infrastructure | Enable CloudTrail in all regions | Not enabled |
| Data encryption in transit | All | TLS infrastructure | Enforce HTTPS, disable plaintext protocols | TODO |

## Gap Analysis

### Critical Gaps (Immediate Action Required)

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

### High Priority Gaps

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

### Medium Priority Gaps

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

## Recommendations

| # | Action | Timeline |
|---|--------|----------|
| 1 | Enable CloudTrail audit logging in all regions | 1 day |
| 2 | Enable S3 default encryption on all buckets | 1 day |
| 3 | Deploy AWS Systems Manager Patch Manager for EC2 | 3 days |
| 4 | Conduct security group audit and remove overly permissive rules | 2 days |
| 5 | Configure HTTPS on ALB and enforce TLS in transit | 2 days |
| 6 | Migrate RDS to an encrypted instance | 1 week |
| 7 | Enable S3 versioning on all buckets | 1 day |
| 8 | Review and tighten IAM role permissions | 2 days |
| 9 | Enable ALB access logging | 1 day |
| 10 | Test RDS backup restore | 2 days |

## Conclusion
Clear understanding of responsibilities is critical. We must implement the 5 identified controls within the next 2 weeks to achieve minimum security baseline.