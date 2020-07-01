terraform {
  required_version = "~> 0.12"

  required_providers {
    aws = "~> 2.66"
  }
}

variable "name" {}

output "bucket_id" {
  value = aws_s3_bucket.main.id
}

output "bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "bucket_domain" {
  value = aws_s3_bucket.main.bucket_domain_name
}
