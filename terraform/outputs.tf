output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "web_server_1_id" {
  description = "EC2 instance ID for web-server-1"
  value       = aws_instance.web_server_1.id
}

output "app_server_1_id" {
  description = "EC2 instance ID for app-server-1"
  value       = aws_instance.app_server_1.id
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.main_database.endpoint
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.web_alb.dns_name
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.app_assets.bucket
}
