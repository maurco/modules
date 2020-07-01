resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.domain
  type    = "A"
  ttl     = 300
  records = [aws_eip.main.public_ip]
}
