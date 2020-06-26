variable "domain" {}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "logs_bucket" {
  default = ""
}

output "zone_id" {
  value = aws_route53_zone.main.zone_id
}
