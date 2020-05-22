resource "aws_acm_certificate" "main" {
  domain_name               = data.aws_route53_zone.main.name
  subject_alternative_names = ["*.${data.aws_route53_zone.main.name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = aws_route53_record.main.*.fqdn
}
