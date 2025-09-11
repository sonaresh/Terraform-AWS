provider "aws" {
  alias  = "Prod"
  region = var.region
  profile = "terraformuser"
  assume_role {
    role_arn = "arn:aws:iam::<AccountID>:role/TerraformProvisioningRole"
  }
}
