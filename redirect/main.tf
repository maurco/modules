variable "zone_id" {}

variable "from_domain" {}

variable "to_domain" {}

variable "protocol" {
  default = "https"
}

resource "aws_s3_bucket" "main" {
  bucket        = var.from_domain
  force_destroy = true

  website {
    redirect_all_requests_to = "${var.protocol}://${var.to_domain}"
  }

  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
}

resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.from_domain
  type    = "A"

  alias {
    name                   = aws_s3_bucket.main.website_domain
    zone_id                = aws_s3_bucket.main.hosted_zone_id
    evaluate_target_health = true
  }
}
