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

module "acm" {
  source               = "../../modules/acm"
  name_prefix          = var.name_prefix
  env                  = var.env
  domain_name          = var.domain_name
  frontend_domain_name = var.frontend_domain_name
  route53_zone_id      = module.route53.zone_id
  route53_zone_name    = module.route53.zone_name
  depends_on           = [module.route53]
}

module "route53" {
  source                        = "../../modules/route53"
  name_prefix                   = var.name_prefix
  env                           = var.env
  domain_name                   = var.domain_name
  frontend_domain_name          = var.frontend_domain_name
  public_load_balancer_dns_name = module.frontend_alb.public_load_balancer_dns_name
  public_load_balancer_zone_id  = module.frontend_alb.public_load_balancer_zone_id
}

module "frontend_alb" {
  source                                  = "../../modules/network/load_balancers/public"
  name_prefix                             = var.name_prefix
  env                                     = var.env
  certificate_arn                         = module.acm.certificate_arn
  vpc_id                                  = module.vpc.vpc_id
  public_load_balancer_security_group_ids = [module.security_groups.frontend_sg_id]
  public_subnet_ids                       = values(module.subnets.public_subnet_ids)
}

module "frontend_ecr" {
  source = "../../modules/ecs/ecr"
  name_prefix = var.name_prefix
  env = var.env
  repository_type = "frontend_app"
}

output "frontend_ecr_repository_url" {
  value = module.frontend_ecr.ecr_repository_url
}
