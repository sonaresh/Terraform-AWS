output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = module.vpc.private_subnet_id
}

output "bastion_instance_id" {
  description = "The ID of the bastion instance"
  value       = module.bastion.bastion_instance_id
}

output "bastion_public_ip" {
  description = "The public IP of the bastion instance"
  value       = module.bastion.bastion_public_ip
}

output "bastion_sg_id" {
  description = "The ID of the bastion security group"
  value       = module.bastion.bastion_sg_id
}

output "web_instance_id" {
  description = "The ID of the web server instance"
  value       = module.web_server.web_instance_id
}

output "web_private_ip" {
  description = "The private IP of the web server instance"
  value       = module.web_server.web_private_ip
}
