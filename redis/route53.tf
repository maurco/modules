resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.name
  type    = "CNAME"
  ttl     = 300
  records = [aws_elasticache_replication_group.main.primary_endpoint_address]
}

resource "aws_route53_record" "read" {
  count   = var.read_replicas > 0 ? 1 : 0
  zone_id = var.zone_id
  name    = "read.${var.name}"
  type    = "CNAME"
  ttl     = 300

  records = [
    replace(aws_elasticache_replication_group.main.primary_endpoint_address, "/^master\\./", "replica."),
  ]
}
