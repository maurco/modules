terraform {
  required_version = "~> 0.12"

  required_providers {
    aws    = "~> 2.66"
    random = "~> 2.2"
  }
}

locals {
  max_allocated_storage = {
    micro  = 16384
    small  = 16384
    medium = 32768
    large  = 65536
  }
  non_encrypted_instance_types = [
    "db.m1.small",
    "db.m1.medium",
    "db.m1.large",
    "db.m1.xlarge",
    "db.m2.xlarge",
    "db.m2.2xlarge",
    "db.m2.4xlarge",
    "db.t2.micro",
  ]
}

variable "name" {}

variable "domain" {}

variable "instance_type" {}

variable "instance_type_replica" {
  default = ""
}

variable "postgres_version" {
  default = "12.3"
}

variable "postgres_port" {
  default = 5432
}

variable "deletion_protection" {
  default = false
}

variable "read_replicas" {
  default = 0
}

variable "multi_az" {
  default = false
}

variable "backup_retention" {
  default = 0
}

variable "backup_window" {
  default = "" # 07:00-09:00
}

variable "maintenance_window" {
  default = "" # Tue:09:00-Tue:11:00
}

variable "monitoring_interval" {
  default = 0
}

variable "performance_insights" {
  default = false
}

variable "performance_insights_retention" {
  default = 0
}

variable "vpc_id" {}

variable "subnet_ids" {}

variable "zone_id" {}

output "security_group_id" {
  value = aws_security_group.main.id
}

output "master_url" {
  value = format("postgres://%s:%s@%s:%s/%s?sslmode=require", aws_db_instance.main.username, aws_db_instance.main.password, aws_route53_record.main.fqdn, aws_db_instance.main.port, aws_db_instance.main.name)
}

output "replica_url" {
  value = length(aws_route53_record.read) > 0 ? format("postgres://%s:%s@%s:%s/%s?sslmode=require", aws_db_instance.main.username, aws_db_instance.main.password, aws_route53_record.read[0].fqdn, aws_db_instance.main.port, aws_db_instance.main.name) : null
}
