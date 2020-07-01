data "aws_route53_zone" "main" {
  zone_id = var.zone_id
}

resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = aws_acm_certificate.main.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.main.domain_validation_options.0.resource_record_type
  ttl     = 300
  records = [
    aws_acm_certificate.main.domain_validation_options.0.resource_record_value,
  ]

  lifecycle {
    create_before_destroy = true
  }
}
