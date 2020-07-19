resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.name
  type    = "CNAME"
  ttl     = 300
  records = [aws_db_instance.main.address]
}

resource "aws_route53_record" "read" {
  count          = length(aws_db_instance.read)
  zone_id        = var.zone_id
  name           = "read.${var.name}"
  type           = "CNAME"
  ttl            = 300
  set_identifier = element(aws_db_instance.read.*.identifier, count.index)
  records        = [element(aws_db_instance.read.*.address, count.index)]

  weighted_routing_policy {
    weight = 1
  }
}
