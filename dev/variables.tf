# variables.tf

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "env_suffix" {
  description = "Environment suffix (e.g., -dev, -prod)"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone for the subnets"
  type        = string
}

variable "bastion_ami_id" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "windows_bastion_ami_id" {
  description = "AMI ID for the Windows bastion host"
  type        = string
}

variable "apache_ami_id" {
  description = "AMI ID for the Apache web server"
  type        = string
}

variable "apache_instance_type" {
  description = "Instance type for the Apache web server"
  type        = string
}

variable "my_ip" {
  description = "Your IP address for SSH access"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

