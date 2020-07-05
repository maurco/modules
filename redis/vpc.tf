resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "main" {
  type                     = "ingress"
  from_port                = var.redis_port
  to_port                  = var.redis_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.main.id
  source_security_group_id = aws_security_group.main.id
}
