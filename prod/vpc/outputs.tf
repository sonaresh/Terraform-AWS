output "vpc_id" {
  value = aws_vpc.Prod_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.Prod_public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.Prod_private_subnet.id
}
