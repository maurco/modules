terraform {
  required_version = "~> 0.13"

  required_providers {
    acme = {
      version = "~> 1"
      source  = "terraform-providers/acme"
    }

    aws = {
      version = "~> 3"
      source  = "hashicorp/aws"
    }

    tls = {
      version = "~> 2"
      source  = "hashicorp/tls"
    }
  }
}

/**
 * Variables
 */

variable "name" {}

variable "email" {}

variable "zone_id" {}

variable "logs_bucket" {
  default = ""
}

locals {
  domain = trim(data.aws_route53_zone.main.name, ".")
}

/**
 * Ouputs
 */

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
