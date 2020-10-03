resource "aws_route53_record" "main" {
  name    = var.from_name
  zone_id = var.zone_id
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "aliases" {
  count   = length(var.from_aliases)
  name    = element(var.from_aliases, count.index)
  zone_id = var.zone_id
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}
