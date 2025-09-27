variable "env_suffix" {
  description = "Environment suffix to append to resource names"
  type        = string
}

variable "bastion_ami_id" {
  description = "AMI ID for the Linux bastion host"
  type        = string
}

variable "windows_bastion_ami_id" {
  description = "AMI ID for the Windows bastion host"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet"
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

variable "my_ip" {
  description = "Your IP address to allow SSH access"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
