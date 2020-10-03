terraform {
  required_version = "~> 0.13"

  required_providers {
    aws = {
      version = "~> 3"
      source  = "hashicorp/aws"
    }
  }
}

/**
 * Variables
 */

variable "name" {}

variable "standard_ia" {
  default = 90 # 3 months
}

variable "glacier" {
  default = 365 # 1 year
}

variable "deep_archive" {
  default = 730 # 2 years
}

variable "expiration" {
  default = 1825 # 5 years
}

/**
 * Outputs
 */

output "bucket_id" {
  value = aws_s3_bucket.main.id
}

output "bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "bucket_domain" {
  value = aws_s3_bucket.main.bucket_domain_name
}
