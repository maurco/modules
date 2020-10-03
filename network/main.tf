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

variable "name" {}

variable "cidr_block" {
  default = "10.10.0.0/16"
}

variable "logs_traffic_type" {
  default = "ALL"
}

variable "logs_bucket" {
  default = ""
}

locals {
  subnet_count = length(data.aws_availability_zones.main.names)
}

/**
 * Outputs
 */

output "vpc_id" {
  value = aws_vpc.main.id
}

output "zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "private_domain" {
  value = trim(aws_route53_zone.main.name, ".")
}
