terraform {
  required_version = "~> 0.13"

  required_providers {
    aws = {
      version = "~> 3"
      source  = "hashicorp/aws"
    }
  }
}

/**
 * Variables
 */

variable "zone_id" {}

# locals {
#   records = {
#     for i, v in flatten([
#       for i, v in aws_acm_certificate.main : [
#         for dno in v.domain_validation_options : {
#           name     = dno.resource_record_name
#           type     = dno.resource_record_type
#           record   = dno.resource_record_value
#           zone_id  = var.zone_ids[i]
#           cert_arn = v.arn
#         }
#       ]
#     ]) :
#     i => v
#   }
# }

/**
 * Ouputs
 */

output "certificate_arn" {
  value = aws_acm_certificate_validation.main.certificate_arn
}
