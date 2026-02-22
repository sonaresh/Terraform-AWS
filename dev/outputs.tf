output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "linux_bastion_id" {
  value = module.bastion.linux_bastion_id
}

output "windows_bastion_id" {
  value = module.bastion.windows_bastion_id
}
