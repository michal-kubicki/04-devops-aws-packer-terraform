#Set the provider to AWS
provider "aws" {
  profile = "default"
  region  = var.aws_region
}

# Get the Ubuntu LAMP AMI
data "aws_ami" "LAMP" {
  most_recent = true
  owners = ["self"]
  filter {
    name = "tag:ID"
    values = ["eu-west-2-US18-04-LAMP"]
  }
}

# Security group
resource "aws_security_group" "ssh-http-s" {
  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = local.all_ips
  }
  ingress {
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }
  ingress {
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }
  ingress {
    from_port   = local.https_port
    to_port     = local.https_port
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }
}

# Start EC2 Instance(s):
resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.LAMP.id
  instance_type               = var.ec2_type
  key_name                    = var.ssh_key
  vpc_security_group_ids      = [aws_security_group.ssh-http-s.id]
  associate_public_ip_address = true
  count                       = var.inst
  tags = {
    name = var.tag_name
  }
}
