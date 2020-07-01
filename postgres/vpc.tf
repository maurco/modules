resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.domain
  }
}

resource "aws_security_group_rule" "main" {
  count                    = length(var.security_group_ids)
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.main.id
  source_security_group_id = element(var.security_group_ids, count.index)
}
