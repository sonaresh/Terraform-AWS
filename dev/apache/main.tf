terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "dev"
  region = var.region
}

resource "tls_private_key" "apache" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "apache" {
  key_name   = "Apache-web-server${var.env_suffix}"
  public_key = tls_private_key.apache.public_key_openssh
}

resource "local_file" "apache_private_key" {
  content  = tls_private_key.apache.private_key_pem
  filename = "${path.module}/Apache-web-server${var.env_suffix}.pem"
}

resource "aws_security_group" "apache_sg" {
  name        = "apache-sg${var.env_suffix}"
  description = "Allow HTTP inbound traffic from bastion hosts"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from Bastion Hosts"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [
      var.linux_bastion_sg_id,
      var.windows_bastion_sg_id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_instance" "apache" {
  ami                         = var.apache_ami_id
  instance_type               = var.apache_instance_type
  subnet_id                   = var.private_subnet_id
  key_name                    = aws_key_pair.apache.key_name
  vpc_security_group_ids      = [aws_security_group.apache_sg.id]
  tags                        = merge(var.tags, { Name = "Apache-web-server${var.env_suffix}" })

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}
