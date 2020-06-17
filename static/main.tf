variable "zone_id" {}

variable "certificate_arn" {}

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
