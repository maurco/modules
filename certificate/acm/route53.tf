data "aws_route53_zone" "main" {
  zone_id = var.zone_id
}

resource "aws_route53_record" "main" {
  for_each = {
    for v in aws_acm_certificate.main.domain_validation_options : v.domain_name => {
      name   = v.resource_record_name
      record = v.resource_record_value
      type   = v.resource_record_type
    }
  }

  zone_id         = var.zone_id
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 300
  allow_overwrite = true
}
