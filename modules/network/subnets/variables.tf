variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
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
  default     = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "myapp"
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Additional tags for the resources"
  type        = map(string)
  default     = {}
}