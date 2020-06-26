variable "zone_id" {}

variable "vpc_id" {}

variable "subnet_id" {}

variable "domain" {}

variable "instance_type" {}

variable "public_key" {}

output "username" {
  value = "openvpn"
}

output "ssh_command" {
  value = format("ssh -p %d openvpnas@%s", random_integer.ssh.result, aws_route53_record.main.fqdn)
}
