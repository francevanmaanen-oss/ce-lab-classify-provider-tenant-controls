# AWS Shared Responsibility Model — Visual Diagram

## Responsibility Layers

```
+------------------------------------------------------------------+
|                     CUSTOMER RESPONSIBILITY                      |
|          Security IN the cloud — managed by the customer         |
|                                                                  |
|  +------------+  +------------+  +----------+  +------------+   |
|  |  Guest OS  |  |Applications|  |   IAM    |  | Encryption |   |
|  | Patching,  |  | Secure code|  |  Roles,  |  | Data at    |   |
|  | hardening  |  | deps, input|  | policies |  | rest/transit|  |
|  +------------+  +------------+  +----------+  +------------+   |
+------------------------------------------------------------------+
                               |
                               |
+------------------------------------------------------------------+
|                        SHARED CONTROLS                           |
|   Patch management, configuration, awareness & training,        |
|   logging — both AWS and customer share responsibility           |
+------------------------------------------------------------------+
                               |
                               |
+------------------------------------------------------------------+
|                      AWS RESPONSIBILITY                          |
|          Security OF the cloud — managed by AWS                  |
|                                                                  |
|  +------------+  +------------------+  +---------------------+  |
|  |  Physical  |  |   Hypervisor     |  |  Managed services   |  |
|  | Data center|  | Compute, storage |  | RDS OS, ALB infra,  |  |
|  | hardware   |  | network hardware |  | Lambda runtime      |  |
|  +------------+  +------------------+  +---------------------+  |
+------------------------------------------------------------------+

## Service Model Quick Reference

Service  | Model    | Responsibility level
---------|----------|---------------------
EC2      | IaaS     | High  — customer manages OS, apps, data
RDS      | PaaS     | Medium — customer manages data and config
S3       | PaaS     | Medium — customer manages access and encryption
ALB      | PaaS     | Low   — customer configures routing only
Lambda   | FaaS     | Low   — customer manages code only
```
