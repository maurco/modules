data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")
  vars = {
    port       = random_integer.ssh.result
    domain     = var.domain
    cidr_block = var.cidr_block
    cert       = var.cert
    ca_bundle  = var.ca_bundle
    priv_key   = var.priv_key
  }
}

data "aws_ami" "openvpn" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server 2.*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "main" {
  key_name   = var.domain
  public_key = var.public_key
}

resource "aws_instance" "main" {
  ami                                  = data.aws_ami.openvpn.id
  instance_type                        = var.instance_type
  key_name                             = aws_key_pair.main.id
  subnet_id                            = var.subnet_id
  user_data                            = data.template_file.user_data.rendered
  vpc_security_group_ids               = [aws_security_group.main.id]
  instance_initiated_shutdown_behavior = "stop"
  tags = {
    Name = var.domain
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "main" {
  vpc = true
  tags = {
    Name = var.domain
  }
}

resource "aws_eip_association" "main" {
  allocation_id = aws_eip.main.id
  instance_id   = aws_instance.main.id
}
