output "web_instance_id" {
  description = "The ID of the web server instance"
  value       = aws_instance.web.id
}

output "web_private_ip" {
  description = "The private IP of the web server instance"
  value       = aws_instance.web.private_ip
}
