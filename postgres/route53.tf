resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.domain
  type    = "CNAME"
  ttl     = 300
  records = [aws_db_instance.main.address]
}

resource "aws_route53_record" "read" {
  count          = length(aws_db_instance.read)
  zone_id        = var.zone_id
  name           = "read.${var.domain}"
  type           = "CNAME"
  ttl            = 300
  records        = [element(aws_db_instance.read.*.address, count.index)]
  set_identifier = element(aws_db_instance.read.*.identifier, count.index)

  weighted_routing_policy {
    weight = 1
  }
}
