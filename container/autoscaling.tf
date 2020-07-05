# resource "aws_appautoscaling_target" "main" {
#   service_namespace  = "ecs"
#   scalable_dimension = "ecs:service:DesiredCount"
#   resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
#   min_capacity       = var.min_capacity
#   max_capacity       = var.max_capacity
# }

# resource "aws_appautoscaling_policy" "up" {
#   name               = "${var.name}-up"
#   resource_id        = aws_appautoscaling_target.main.resource_id
#   scalable_dimension = aws_appautoscaling_target.main.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.main.service_namespace

#   step_scaling_policy_configuration {
#     adjustment_type         = "ChangeInCapacity"
#     metric_aggregation_type = "Average"
#     cooldown                = 60

#     step_adjustment {
#       metric_interval_lower_bound = 0
#       scaling_adjustment          = 1
#     }
#   }
# }

# resource "aws_appautoscaling_policy" "down" {
#   name               = "${var.name}-down"
#   resource_id        = aws_appautoscaling_target.main.resource_id
#   scalable_dimension = aws_appautoscaling_target.main.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.main.service_namespace

#   step_scaling_policy_configuration {
#     adjustment_type         = "ChangeInCapacity"
#     metric_aggregation_type = "Average"
#     cooldown                = 60

#     step_adjustment {
#       metric_interval_lower_bound = 0
#       scaling_adjustment          = -1
#     }
#   }
# }
