terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  profile = "agripass"
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

module "security_groups" {
  source      = "../../modules/network/security_groups"
  vpc_id      = module.vpc.vpc_id
  name_prefix = var.name_prefix
  env         = var.env
}

output "frontend_sg_id" {
  value = module.security_groups.frontend_sg_id
}

output "backend_sg_id" {
  value = module.security_groups.backend_sg_id
}

output "rds_sg_id" {
  value = module.security_groups.rds_sg_id
}