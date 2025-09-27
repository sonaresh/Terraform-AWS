
module "vpc" {
  source = "./vpc"

  providers = {
    aws = aws.dev
  }

  region              = var.region
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
  tags                = var.tags
  vpc_name            = var.vpc_name
}

module "bastion" {
  source = "./bastion"

  providers = {
    aws = aws.dev
  }

  bastion_ami_id         = var.bastion_ami_id
  windows_bastion_ami_id = var.windows_bastion_ami_id
  public_subnet_id       = module.vpc.public_subnet_id
  tags                   = var.tags
  env_suffix             = var.env_suffix
  vpc_id                 = module.vpc.vpc_id
  my_ip                  = var.my_ip
  region                 = var.region
}

module "apache" {
  source = "./apache"

  providers = {
    aws = aws.dev
  }

  apache_ami_id         = var.apache_ami_id
  apache_instance_type  = var.apache_instance_type
  private_subnet_id     = module.vpc.private_subnet_id
  tags                  = var.tags
  env_suffix            = var.env_suffix
  vpc_id                = module.vpc.vpc_id
  linux_bastion_sg_id   = module.bastion.linux_bastion_sg_id
  windows_bastion_sg_id = module.bastion.windows_bastion_sg_id
  region                = var.region
}

