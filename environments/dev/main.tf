terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}


module "vpc" {
  source         = "../../modules/network/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  name_prefix    = var.name_prefix
  env            = var.env
  tags           = var.tags
}

module "subnets" {
  source                     = "../../modules/network/subnets"
  vpc_id                     = module.vpc.vpc_id
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones         = var.availability_zones
  name_prefix                = var.name_prefix
  env                        = var.env
  tags                       = var.tags
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}