terraform {
  required_version = "~> 0.12"

  required_providers {
    acme = "~> 1.5"
    aws  = "~> 2.66"
    tls  = "~> 2.1"
  }
}

locals {
  domain = trim(data.aws_route53_zone.main.name, ".")
}

variable "name" {}

variable "email" {}

variable "logs_bucket" {}

variable "zone_id" {}

output "cert_url" {
  value = "s3://${aws_s3_bucket.main.id}/${aws_s3_bucket_object.cert.id}"
}

output "chain_url" {
  value = "s3://${aws_s3_bucket.main.id}/${aws_s3_bucket_object.chain.id}"
}

output "fullchain_url" {
  value = "s3://${aws_s3_bucket.main.id}/${aws_s3_bucket_object.fullchain.id}"
}

output "privkey_url" {
  value = "s3://${aws_s3_bucket.main.id}/${aws_s3_bucket_object.privkey.id}"
}

output "bucket_id" {
  value = aws_s3_bucket.main.id
}

output "certificate_arn" {
  value = aws_acm_certificate_validation.main.certificate_arn
}
