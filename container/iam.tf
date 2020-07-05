data "aws_iam_policy_document" "main" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com",
        # "application-autoscaling.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "main" {
  assume_role_policy = data.aws_iam_policy_document.main.json
}

resource "aws_iam_role_policy_attachment" "task_execution" {
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# resource "aws_iam_role_policy_attachment" "service_autoscale" {
#   role       = aws_iam_role.main.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
# }

resource "aws_iam_role" "container" {
  assume_role_policy = data.aws_iam_policy_document.main.json
}

resource "aws_iam_role_policy_attachment" "power_user" {
  role       = aws_iam_role.container.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
