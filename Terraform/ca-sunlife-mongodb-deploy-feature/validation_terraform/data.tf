data "aws_subnet" "subnet_priv_a1" {
  vpc_id = var.aws_vpc
  tags = {
    Name = "*-priv-a1"
  }
}

data "aws_subnet" "subnet_priv_b1" {
  vpc_id = var.aws_vpc
  tags = {
    Name = "*-priv-b1"
  }
}

data "aws_subnet" "subnet_priv_c1" {
  vpc_id = var.aws_vpc
  tags = {
    Name = "*-priv-c1"
  }
}

data "aws_security_group" "vpc_security_groups" {
  vpc_id = var.aws_vpc
  tags = {
    Name = "*security_group"
  }
}

data "aws_ami" "application_image" {
  most_recent = true
  owners      = [var.aws_account_id]
  filter {
    name   = "tag:os_type"
    values = [var.ec2_tagging.tag_os_type]
  }
  filter {
    name   = "tag:os_version"
    values = [var.ec2_tagging.tag_os_version]
  }
  filter {
    name   = "tag:active"
    values = [true]
  }
  filter {
    name   = "is-public"
    values = [false]
  }
}