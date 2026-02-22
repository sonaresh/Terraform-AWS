output "bastion_instance_id" {
  description = "The ID of the bastion instance"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "The public IP of the bastion instance"
  value       = aws_instance.bastion.public_ip
}

output "bastion_sg_id" {
  description = "The ID of the bastion security group"
  value       = aws_security_group.bastion_sg.id
}
