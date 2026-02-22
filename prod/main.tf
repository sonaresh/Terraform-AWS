module "vpc" {
  source = "./vpc"
  providers = {
    aws = aws.Prod
  }
  region              = var.region
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
  tags                = var.tags
  vpc_name            = var.vpc_name
}

module "iam" {
  source = "./iam"
  providers = {
    aws = aws.Prod
  }
  region = var.region
}

module "bastion" {
  source = "./bastion"
  providers = {
    aws = aws.Prod
  }
  region                    = var.region
  vpc_id                    = module.vpc.vpc_id
  public_subnet_id          = module.vpc.public_subnet_id
  ami_id                    = var.bastion_ami_id
  instance_type             = var.bastion_instance_type
  key_name                  = var.bastion_key_name
  tags                      = var.tags
  ssm_instance_profile_name = module.iam.ssm_instance_profile_name
}

module "web_server" {
  source = "./web_server"
  providers = {
    aws = aws.Prod
  }
  region                    = var.region
  vpc_id                    = module.vpc.vpc_id
  private_subnet_id         = module.vpc.private_subnet_id
  linux_bastion_sg_id       = module.bastion.bastion_sg_id
  windows_bastion_sg_id     = module.windows_bastion.windows_bastion_sg_id
  ami_id                    = var.web_ami_id
  instance_type             = var.web_instance_type
  key_name                  = var.web_key_name
  tags                      = var.tags
  ssm_instance_profile_name = module.iam.ssm_instance_profile_name
}

module "windows_bastion" {
  source = "./windows_bastion"
  providers = {
    aws = aws.Prod
  }
  region                    = var.region
  vpc_id                    = module.vpc.vpc_id
  public_subnet_id          = module.vpc.public_subnet_id
  ami_id                    = var.windows_bastion_ami_id
  instance_type             = var.windows_bastion_instance_type
  key_name                  = var.windows_bastion_key_name
  tags                      = var.tags
  ssm_instance_profile_name = module.iam.ssm_instance_profile_name
}
