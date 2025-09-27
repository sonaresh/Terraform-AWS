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

resource "tls_private_key" "linux_bastion" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_private_key" "windows_bastion" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "linux_bastion" {
  key_name   = "Linux-bastion${var.env_suffix}"
  public_key = tls_private_key.linux_bastion.public_key_openssh
}

resource "aws_key_pair" "windows_bastion" {
  key_name   = "Windows-bastion${var.env_suffix}"
  public_key = tls_private_key.windows_bastion.public_key_openssh
}

resource "local_file" "linux_bastion_private_key" {
  content  = tls_private_key.linux_bastion.private_key_pem
  filename = "${path.module}/Linux-bastion${var.env_suffix}.pem"
}

resource "local_file" "windows_bastion_private_key" {
  content  = tls_private_key.windows_bastion.private_key_pem
  filename = "${path.module}/Windows-bastion${var.env_suffix}.pem"
}

resource "aws_security_group" "linux_bastion_sg" {
  name        = "linux-bastion-sg${var.env_suffix}"
  description = "Allow SSH inbound traffic for Linux bastion"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group" "windows_bastion_sg" {
  name        = "windows-bastion-sg${var.env_suffix}"
  description = "Allow RDP inbound traffic for Windows bastion"
  vpc_id      = var.vpc_id

  ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_instance" "linux_bastion" {
  ami                         = var.bastion_ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  key_name                    = aws_key_pair.linux_bastion.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.linux_bastion_sg.id]
  tags                        = merge(var.tags, { Name = "Linux-bastion${var.env_suffix}" })
}

resource "aws_instance" "windows_bastion" {
  ami                         = var.windows_bastion_ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  key_name                    = aws_key_pair.windows_bastion.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.windows_bastion_sg.id]
  tags                        = merge(var.tags, { Name = "Windows-bastion${var.env_suffix}" })
}
