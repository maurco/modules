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

output "bucket_id" {
  value = aws_s3_bucket.main.id
}

output "bucket_path_cert" {
  value = aws_s3_bucket_object.cert.id
}

output "bucket_path_chain" {
  value = aws_s3_bucket_object.chain.id
}

output "bucket_path_full_chain" {
  value = aws_s3_bucket_object.fullchain.id
}

output "bucket_path_priv_key" {
  value = aws_s3_bucket_object.privkey.id
}

output "certificate_arn" {
  value = aws_acm_certificate_validation.main.certificate_arn
}
