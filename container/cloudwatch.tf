resource "aws_cloudwatch_log_group" "main" {
  name              = var.name
  retention_in_days = var.logs_retention
}

# resource "aws_cloudwatch_metric_alarm" "up" {
#   alarm_name          = "${var.name} (scale up)"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ECS"
#   statistic           = "Average"
#   threshold           = 80
#   period              = 60
#   evaluation_periods  = 2
#   alarm_actions       = [aws_appautoscaling_policy.up.arn]
#   dimensions = {
#     ClusterName = aws_ecs_cluster.main.name
#     ServiceName = aws_ecs_service.main.name
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "down" {
#   alarm_name          = "${var.name} (scale down)"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ECS"
#   statistic           = "Average"
#   threshold           = 20
#   period              = 60
#   evaluation_periods  = 2
#   alarm_actions       = [aws_appautoscaling_policy.down.arn]
#   dimensions = {
#     ClusterName = aws_ecs_cluster.main.name
#     ServiceName = aws_ecs_service.main.name
#   }
# }
