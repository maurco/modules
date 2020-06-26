resource "aws_route53_zone" "main" {
  name = var.domain

  vpc {
    vpc_id = aws_vpc.main.id
  }
}
