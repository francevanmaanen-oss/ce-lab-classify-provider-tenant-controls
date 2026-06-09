variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances (Amazon Linux 2)"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 in us-east-1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "adminuser"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "s3_bucket_name" {
  description = "Globally unique name for the S3 assets bucket"
  type        = string
  default     = "my-app-assets-lab"
}
