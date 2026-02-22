variable "env_suffix" {
  description = "Environment suffix to append to resource names"
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

variable "private_subnet_id" {
  description = "The ID of the private subnet"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "linux_bastion_sg_id" {
  description = "Security group ID of the Linux bastion"
  type        = string
}

variable "windows_bastion_sg_id" {
  description = "Security group ID of the Windows bastion"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
