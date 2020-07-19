resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "main" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = var.postgres_port
  to_port                  = var.postgres_port
  security_group_id        = aws_security_group.main.id
  source_security_group_id = aws_security_group.main.id
}
