data "aws_availability_zones" "main" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = var.name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public" {
  count                   = local.subnet_count
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.main.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, ceil(log(local.subnet_count * 2, 2)), count.index + 1)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name} (public)"
  }
}

resource "aws_subnet" "private" {
  count                   = local.subnet_count
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.main.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, ceil(log(local.subnet_count * 2, 2)), local.subnet_count + count.index + 1)
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.name} (private)"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.name} (public)"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.name} (private)"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
