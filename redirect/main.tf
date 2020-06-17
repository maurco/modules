variable "zone_id" {}

variable "certificate_arn" {}

variable "from_domain" {}

variable "to_domain" {}

variable "to_protocol" {
  default = "https"
}

variable "aliases" {
  default = []
}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.main.id
}
