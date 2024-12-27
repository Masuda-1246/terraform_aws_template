variable "domain_name" {
  description = "The domain name for the Route53 zone"
  type        = string
}

variable "frontend_domain_name" {
  description = "The domain name for the frontend"
  type        = string
}

variable "public_load_balancer_dns_name" {
  description = "The DNS name of the public load balancer"
  type        = string
}
variable "public_load_balancer_zone_id" {
  description = "The HostedZone ID of the public load balancer"
  type        = string
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