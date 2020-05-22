locals {
  s3_origin_id = "s3-origin"
}

variable "zone_id" {}

variable "certificate_arn" {}

variable "to" {}

variable "from_domain" {}

variable "from_subdomains" {
  default = []
}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.main.id
}
