terraform {
  required_version = "~> 0.12"

  required_providers {
    aws    = "~> 2.66"
    random = "~> 2.2"
  }
}

variable "domain" {}

variable "aliases" {
  default = []
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

variable "logs_bucket" {
  default = ""
}

variable "certificate_arn" {}

variable "zone_id" {}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.main.id
}
