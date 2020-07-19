terraform {
  required_version = "~> 0.12"

  required_providers {
    aws    = "~> 2.66"
    random = "~> 2.2"
  }
}

variable "name" {}

variable "instance_type" {}

variable "redis_version" {
  default = "5.0.6"
}

variable "redis_port" {
  default = 6379
}

variable "read_replicas" {
  default = 0
}

# variable "multi_az" {
#   default = false
# }

variable "automatic_failover" {
  default = false
}

variable "backup_retention" {
  default = 0
}

variable "backup_window" {
  default     = ""
  description = "07:00-09:00"
}

variable "maintenance_window" {
  default     = ""
  description = "Tue:09:00-Tue:11:00"
}

variable "vpc_id" {}

variable "subnet_ids" {}

variable "zone_id" {}

output "security_group_id" {
  value = aws_security_group.main.id
}

output "master_url" {
  value = format("rediss://%s:%s", aws_route53_record.main.fqdn, aws_elasticache_replication_group.main.port)
}

output "replica_url" {
  value = length(aws_route53_record.read) > 0 ? format("rediss://%s:%s", aws_route53_record.read[0].fqdn, aws_elasticache_replication_group.main.port) : null
}
