output "windows_bastion_instance_id" {
  description = "The ID of the Windows bastion instance"
  value       = aws_instance.windows_bastion.id
}

output "windows_bastion_public_ip" {
  description = "The public IP of the Windows bastion instance"
  value       = aws_instance.windows_bastion.public_ip
}

output "windows_bastion_sg_id" {
  description = "The ID of the Windows bastion security group"
  value       = aws_security_group.windows_bastion_sg.id
}
