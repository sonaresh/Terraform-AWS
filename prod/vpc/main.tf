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

resource "aws_vpc" "Prod_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = merge(var.tags, { Name = var.vpc_name })
}

resource "aws_subnet" "Prod_private_subnet" {
  vpc_id                  = aws_vpc.Prod_vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false

  tags = merge(var.tags, { Name = "Private_Subnet_Prod" })
}

resource "aws_subnet" "Prod_public_subnet" {
  vpc_id                  = aws_vpc.Prod_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = merge(var.tags, { Name = "Public_Subnet_Prod" })
}

resource "aws_internet_gateway" "Prod_igw" {
  vpc_id = aws_vpc.Prod_vpc.id

  tags = merge(var.tags, { Name = "Internet_Gateway_Prod" })
}

resource "aws_route_table" "Prod_public_rt" {
  vpc_id = aws_vpc.Prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Prod_igw.id
  }

  tags = merge(var.tags, { Name = "Public_Route_Table_Prod" })
}

resource "aws_route_table_association" "Prod_public_rt_assoc" {
  subnet_id      = aws_subnet.Prod_public_subnet.id
  route_table_id = aws_route_table.Prod_public_rt.id
}

resource "aws_route_table" "Prod_private_rt" {
  vpc_id = aws_vpc.Prod_vpc.id

  tags = merge(var.tags, { Name = "Private_Route_Table_Prod" })
}

resource "aws_route_table_association" "Prod_private_rt_assoc" {
  subnet_id      = aws_subnet.Prod_private_subnet.id
  route_table_id = aws_route_table.Prod_private_rt.id
}
