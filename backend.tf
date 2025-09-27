terraform {
  backend "s3" {
    bucket   = "terra-state-dev-992382446249"
    key      = "dev/terraform.tfstate"
    region   = "us-west-2"
    profile  = "terraformuser"
    role_arn = "arn:aws:iam::992382446249:role/TerraformProvisioningRole"
  }
}
