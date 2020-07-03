terraform {
  required_version = "~> 0.12"

  required_providers {
    aws = "~> 2.66"
  }
}

variable "domain" {}

variable "redirect_root_to" {
  default = ""
}

variable "private_prefix" {
  default = "private"
}

variable "noncurrent_version_expiration" {
  default = 14
}

variable "logs_bucket" {
  default = ""
}

variable "certificate_arn" {}

variable "zone_id" {}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.main.id
}
