terraform {
  required_version = "~> 0.12"

  required_providers {
    aws    = "~> 2.66"
    random = "~> 2.2"
  }
}

variable "from_name" {}

variable "to_name" {}

variable "to_protocol" {
  default = "https"
}

variable "aliases" {
  default = []
}

variable "price_class" {
  default = "PriceClass_100"
}

variable "logs_bucket" {
  default = ""
}

variable "certificate_arn" {}

variable "zone_id" {}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.main.id
}
