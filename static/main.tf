variable "zone_id" {}

variable "certificate_arn" {}

variable "logs_bucket" {
  default = ""
}

variable "domain" {}

variable "aliases" {
  default = []
}

variable "app_page" {
  default = ""
}

variable "not_found_page" {
  default = "/404.html"
}

variable "error_page" {
  default = "/500.html"
}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.main.id
}
