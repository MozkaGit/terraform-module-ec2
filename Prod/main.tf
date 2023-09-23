provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["$HOME/.aws/credentials"]
}

terraform {
  backend "s3" {
    bucket                  = "terraform-backend-mozka"
    key                     = "prod.tfstate"
    region                  = "us-east-1"
    shared_credentials_file = "$HOME/.aws/credentials"
  }
}

module "ec2-module" {
  source       = "../Modules/ec2module"
  instancetype = var.instancetype

  aws_name_tag = var.aws_name_tag

  key-pairs = var.key-pairs

  private-key = var.private-key
}