terraform {
  required_version = "~> 0.12"

  required_providers {
    aws = "~> 2.66"
  }
}

variable "name" {}

variable "price_class" {
  default = "PriceClass_All"
}

variable "redirect_root" {
  default = ""
}

variable "private_prefix" {
  default = "private/"
}

variable "private_signers" {
  default = ["self"]
}

variable "noncurrent_expiration" {
  default = 14
}

variable "index_html" {
  default = ""
}

variable "not_found_html" {
  default = ""
}

variable "logs_bucket" {
  default = ""
}

variable "certificate_arn" {}

variable "zone_id" {}

output "bucket_id" {
  value = aws_s3_bucket.main.id
}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.main.id
}
