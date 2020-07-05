resource "aws_lb" "main" {
  subnets                    = var.subnet_ids
  security_groups            = [aws_security_group.main.id]
  enable_deletion_protection = var.deletion_protection

  access_logs {
    bucket  = var.logs_bucket
    enabled = true
  }
}

resource "aws_lb_target_group" "main" {
  port                          = 80
  protocol                      = "HTTP"
  target_type                   = "ip"
  deregistration_delay          = var.deregistration_delay
  load_balancing_algorithm_type = var.load_balancing_algorithm_type
  vpc_id                        = var.vpc_id

  health_check {
    path = var.health_check_path
  }
}

resource "aws_lb_listener" "main" {
  port              = 443
  protocol          = "HTTPS"
  load_balancer_arn = aws_lb.main.arn
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener" "redirect" {
  port              = 80
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.main.arn

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
