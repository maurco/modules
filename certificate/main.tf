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

variable "email_address" {}

variable "zone_id" {}

output "cert_pem" {
  value = acme_certificate.main.certificate_pem
}

output "ca_bundle" {
  value = "${acme_certificate.main.certificate_pem}${acme_certificate.main.issuer_pem}"
}

output "priv_key" {
  value = tls_private_key.main.private_key_pem
}

output "certificate_arn" {
  value = aws_acm_certificate_validation.main.certificate_arn
}
