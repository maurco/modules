terraform {
  required_version = "~> 0.12"

  required_providers {
    aws = "~> 2.66"
  }
}

variable "from_domain" {}

variable "to_domain" {}

variable "to_protocol" {
  default = "https"
}

variable "aliases" {
  default = []
}

variable "logs_bucket" {
  default = ""
}

variable "certificate_arn" {}

variable "zone_id" {}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.main.id
}
