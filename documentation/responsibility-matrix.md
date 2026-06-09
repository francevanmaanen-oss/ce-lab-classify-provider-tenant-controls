# Security Controls by Category

## Network Security

| Control | AWS | Customer | Status |
|---------|-----|----------|--------|
| VPC isolation | Hypervisor-level network isolation | VPC design, subnet configuration | Configured |
| Security groups | Security group infrastructure | Define and review inbound/outbound rules | Review needed |
| NACLs | NACL infrastructure | Configure NACL rules per subnet | Configured |
| DDoS protection | AWS Shield Standard (always on) | Optionally enable Shield Advanced | Advanced not enabled |

## Compute Security (EC2)

| Control | AWS | Customer | Status |
|---------|-----|----------|--------|
| Host OS | Patching and security of underlying host | None | AWS Managed |
| Guest OS | None | Patching, hardening, antivirus on EC2 instances | TODO |
| Application security | None | Secure coding, dependency scanning, input validation | TODO |
| IAM role | IAM infrastructure | Policy configuration and least privilege | Configured |
| Instance isolation | Hypervisor-level isolation between instances | None | AWS Managed |

## Database Security (RDS)

| Control | AWS | Customer | Status |
|---------|-----|----------|--------|
| Database OS | OS patching | None | AWS Managed |
| Database engine | Patching within maintenance window | Schedule maintenance window, test after update | Configured |
| Encryption at rest | KMS infrastructure | Enable encryption on RDS instance | TODO |
| Network access | Infrastructure | Security groups, private subnet placement | Configured |
| Backup | Automated backup infrastructure | Configure retention period, test restore | Test restore needed |

## Data Security (S3)

| Control | AWS | Customer | Status |
|---------|-----|----------|--------|
| Storage infrastructure | Redundancy and durability | None | AWS Managed |
| Encryption at rest | KMS infrastructure | Enable default encryption on all buckets | TODO |
| Bucket policies | Policy enforcement infrastructure | Write and review bucket policies | Review needed |
| Public access | Block Public Access infrastructure | Enable Block Public Access setting | Configured |
| Versioning | Versioning infrastructure | Enable versioning on all buckets | Not enabled |