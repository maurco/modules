variable "logs_bucket" {
  default = ""
}

variable "domain" {}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}
