resource "aws_flow_log" "main" {
  count                = var.logs_bucket == "" ? 0 : 1
  vpc_id               = aws_vpc.main.id
  log_destination      = var.logs_bucket
  log_destination_type = "s3"
  traffic_type         = "ALL"
}
