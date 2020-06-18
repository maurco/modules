variable "zone_id" {}

variable "certificate_arn" {}

variable "domain" {}

variable "trusted_signers" {
  default = []
}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.main.id
}
