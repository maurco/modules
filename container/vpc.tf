resource "aws_security_group" "main" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.container.id]
  }
}

resource "aws_security_group" "container" {
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "container_ingress" {
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.main.id
  security_group_id        = aws_security_group.container.id
}

resource "aws_security_group_rule" "container_egress_tcp" {
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.container.id
}

resource "aws_security_group_rule" "container_egress_udp" {
  from_port         = 443
  to_port           = 443
  protocol          = "udp"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.container.id
}
