variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the Windows bastion host"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the Windows bastion host"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the Windows bastion host"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "ssm_instance_profile_name" {
  description = "The name of the IAM instance profile for SSM"
  type        = string
}
