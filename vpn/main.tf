terraform {
  required_version = "~> 0.12"

  required_providers {
    aws      = "~> 2.66"
    random   = "~> 2.2"
    template = "~> 2.1"
  }
}

variable "domain" {}

variable "instance_type" {}

variable "public_key" {}

variable "cert" {
  default = ""
}

variable "ca_bundle" {
  default = ""
}

variable "priv_key" {
  default = ""
}

variable "cidr_block" {
  default = "10.0.0.0/16"
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

output "ssh_command" {
  value = format("ssh -p %d openvpnas@%s", random_integer.ssh.result, aws_route53_record.main.fqdn)
}
