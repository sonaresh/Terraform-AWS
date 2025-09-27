variable "region" {
  description = "The AWS region to deploy resources in"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
}

variable "availability_zone" {
  description = "The availability zone to deploy resources in"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "vpc_name" {
  description = "The name of the VPC"
}
