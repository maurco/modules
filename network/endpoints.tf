data "aws_region" "main" {}

resource "aws_vpc_endpoint" "s3" {
  vpc_id          = aws_vpc.main.id
  service_name    = "com.amazonaws.${data.aws_region.main.name}.s3"
  route_table_ids = [aws_route_table.public.id, aws_route_table.private.id]
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id          = aws_vpc.main.id
  service_name    = "com.amazonaws.${data.aws_region.main.name}.dynamodb"
  route_table_ids = [aws_route_table.public.id, aws_route_table.private.id]
}
