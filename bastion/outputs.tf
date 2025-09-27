output "linux_bastion_id" {
  value = aws_instance.linux_bastion.id
}

output "windows_bastion_id" {
  value = aws_instance.windows_bastion.id
}

output "linux_bastion_sg_id" {
  value = aws_security_group.linux_bastion_sg.id
}

output "windows_bastion_sg_id" {
  value = aws_security_group.windows_bastion_sg.id
}

output "linux_bastion_key_name" {
  value = aws_key_pair.linux_bastion.key_name
}
