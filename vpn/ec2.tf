data "template_file" "user_data" {
  template = file("${path.module}/ec2-user-data.yml")
  vars = {
    name       = var.name
    bucket     = var.certificate_bucket
    cert       = var.certificate_cert
    full_chain = var.certificate_full_chain
    priv_key   = var.certificate_priv_key
    cidr_block = data.aws_vpc.main.cidr_block
  }
}

data "aws_ami" "vpn" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["OpenVPN Access Server 2.*"]
  }
}

resource "aws_key_pair" "main" {
  public_key = var.public_key
}

resource "aws_eip" "main" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "main" {
  ami                                  = data.aws_ami.vpn.id
  instance_type                        = var.instance_type
  subnet_id                            = var.subnet_id
  user_data_base64                     = base64encode(data.template_file.user_data.rendered)
  iam_instance_profile                 = aws_iam_instance_profile.main.id
  vpc_security_group_ids               = concat(var.security_group_ids, [aws_security_group.main.id])
  key_name                             = aws_key_pair.main.id
  instance_initiated_shutdown_behavior = "stop"
  tags = {
    Name = var.name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip_association" "main" {
  allocation_id = aws_eip.main.id
  instance_id   = aws_instance.main.id
}
