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

variable "from_name" {}

variable "from_aliases" {
  default = []
}

variable "to_name" {}

variable "to_protocol" {
  default = "https"
}

variable "price_class" {
  default = "PriceClass_100"
}

variable "certificate_arn" {}

variable "zone_id" {}

variable "logs_bucket" {
  default = ""
}

/**
 * Outputs
 */

output "cloudfront_id" {
  value = aws_cloudfront_distribution.main.id
}
