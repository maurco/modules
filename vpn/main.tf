terraform {
  required_version = "~> 0.12"

  required_providers {
    aws      = "~> 2.66"
    template = "~> 2.1"
  }
}

variable "name" {}

variable "instance_type" {}

variable "public_key" {}

variable "certificate_bucket" {}

variable "certificate_cert" {
  default = "cert.pem"
}

variable "certificate_full_chain" {
  default = "fullchain.pem"
}

variable "certificate_priv_key" {
  default = "privkey.pem"
}

variable "vpc_id" {}

variable "subnet_id" {}

variable "zone_id" {}

variable "security_group_ids" {
  default = []
}

output "web_url" {
  value = format("https://%s:943", aws_route53_record.main.fqdn)
}

output "ssh_url" {
  value = format("ssh://openvpnas@%s", aws_route53_record.main.fqdn)
}
