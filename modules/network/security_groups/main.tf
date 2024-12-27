module "frontend_sg" {
  source      = "./security_group"
  name_prefix = var.name_prefix
  env         = var.env
  name        = "frontend"
  description = "Security group for frontend"
  vpc_id      = var.vpc_id
  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP from anywhere"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS from anywhere"
    },
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow frontend port from anywhere"
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
  tags = {
    Name = "${var.name_prefix}-${var.env}-frontend-sg"
  }
}

module "backend_sg" {
  source      = "./security_group"
  name_prefix = var.name_prefix
  env         = var.env
  name        = "backend"
  description = "Security group for backend"
  vpc_id      = var.vpc_id
  ingress_rules = [
    {
      from_port       = 3001
      to_port         = 3001
      protocol        = "tcp"
      security_groups = [module.frontend_sg.security_group_id]
      description     = "Allow NestJS port from frontend"
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
  tags = {
    Name = "${var.name_prefix}-${var.env}-backend-sg"
  }
}

module "rds_sg" {
  source      = "./security_group"
  name_prefix = var.name_prefix
  env         = var.env
  name        = "rds"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id
  ingress_rules = [
    {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      security_groups = [module.backend_sg.security_group_id]
      description     = "Allow PostgreSQL port from backend"
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
  tags = {
    Name = "${var.name_prefix}-${var.env}-rds-sg"
  }
}