terraform {
  required_version = "~> 0.13"

  required_providers {
    aws = {
      version = "~> 3"
      source  = "hashicorp/aws"
    }

    random = {
      version = "~> 2"
      source  = "hashicorp/random"
    }
  }
}

/**
 * Variables
 */

variable "name" {}

variable "price_class" {
  default = "PriceClass_All"
}

variable "app_page" {
  default = ""
}

variable "not_found_page" {
  default = "/404.html"
}

variable "error_page" {
  default = "/500.html"
}

variable "certificate_arn" {}

variable "zone_id" {}

variable "logs_bucket" {
  default = ""
}

/**
 * Outputs
 */

output "bucket_id" {
  value = aws_s3_bucket.main.id
}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.main.id
}
