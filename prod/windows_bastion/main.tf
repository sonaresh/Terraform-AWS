terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "Prod"
  region = var.region
}

# Security Group for Windows Bastion
resource "aws_security_group" "windows_bastion_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "Windows_Bastion_Prod Security Group" })
}

# Windows Bastion Instance
resource "aws_instance" "windows_bastion" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.windows_bastion_sg.id]
  iam_instance_profile   = var.ssm_instance_profile_name

  user_data = <<-EOF
              <powershell>
              Invoke-WebRequest -Uri https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/Windows/amd64/AmazonSSMAgentSetup.exe -OutFile $env:USERPROFILE\Desktop\SSMAgent_latest.exe
              Start-Process -FilePath $env:USERPROFILE\Desktop\SSMAgent_latest.exe -ArgumentList /S -Wait
              Remove-Item -Path $env:USERPROFILE\Desktop\SSMAgent_latest.exe
              </powershell>
              EOF

  tags = merge(var.tags, { Name = "Windows_Bastion_Prod" })
}
