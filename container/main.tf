terraform {
  required_version = "~> 0.12"

  required_providers {
    aws = "~> 2.66"
  }
}

locals {
  environment = join(", ", formatlist("{ \"name\": \"%s\", \"value\": \"%v\" }", keys(var.env_vars), values(var.env_vars)))
  revision    = max(aws_ecs_task_definition.main.revision, data.aws_ecs_task_definition.main.revision)
  port        = lookup(var.env_vars, "PORT", 80)
}

variable "name" {}

variable "domain" {}

variable "capacity" {
  default = 1
}

variable "cpu" {
  default = 256
}

variable "memory" {
  default = 512
}

variable "deletion_protection" {
  default = false
}

variable "health_check_path" {
  default = "/"
}

variable "deregistration_delay" {
  default = 60
}

variable "load_balancing_algorithm_type" {
  default = "least_outstanding_requests"
}

variable "logs_retention" {
  default = 180
}

variable "logs_bucket" {}

variable "certificate_arn" {}

variable "vpc_id" {}

variable "subnet_ids" {}

variable "zone_id" {}

variable "security_group_ids" {
  default = []
}

variable "env_vars" {
  default = {}
}

output "repository_url" {
  value = aws_ecr_repository.main.repository_url
}
