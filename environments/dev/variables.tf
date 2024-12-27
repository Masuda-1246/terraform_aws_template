variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "my-app"
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags for the cloudwatch resource"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["ap-northeast-1c", "ap-northeast-1d"]
}

variable "domain_name" {
  description = "The domain name for the Route53 zone"
  type        = string
  default     = "agrico-stg.work"
}
variable "frontend_domain_name" {
  description = "The domain name for the frontend"
  type        = string
  default     = "www.agrico-stg.work"
}