data "aws_region" "main" {}

data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.main.family
}

resource "aws_ecs_cluster" "main" {
  name = var.name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = var.name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.main.arn
  task_role_arn            = aws_iam_role.container.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "${var.name}",
    "image": "${aws_ecr_repository.main.repository_url}:latest",
    "essential": true,
    "environment": [${local.environment}],
    "portMappings": [
      {
        "hostPort": ${local.port},
        "containerPort": ${local.port}
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-stream-prefix": "ecs",
        "awslogs-region": "${data.aws_region.main.name}",
        "awslogs-group": "${aws_cloudwatch_log_group.main.name}"
      }
    }
  }
]
TASK_DEFINITION
}

resource "aws_ecs_service" "main" {
  name                               = var.name
  cluster                            = aws_ecs_cluster.main.id
  launch_type                        = "FARGATE"
  task_definition                    = "${aws_ecs_task_definition.main.family}:${local.revision}"
  desired_count                      = var.capacity
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  load_balancer {
    container_name   = var.name
    container_port   = local.port
    target_group_arn = aws_lb_target_group.main.arn
  }

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = concat(var.security_group_ids, [aws_security_group.container.id])
    assign_public_ip = true # required to pull ECR image and register with cluster
  }
}
