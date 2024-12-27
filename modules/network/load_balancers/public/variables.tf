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

variable "public_subnet_ids" {
  description = "List of IDs for public subnets"
  type        = list(string)
}

variable "public_load_balancer_security_group_ids" {
  description = "Security group ID for the public load balancer"
  type        = list(string)
}
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "certificate_arn" {
  description = "ARN of the SSL certificate"
  type        = string
}