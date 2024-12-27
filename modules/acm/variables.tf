variable "domain_name" {
  description = "The domain name for the certificate"
  type        = string
}
variable "frontend_domain_name" {
  description = "The frontend domain name for the certificate"
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
  description = "Tags for the acm resource"
  type        = map(string)
  default     = {}
}

variable "route53_zone_id" {
  description = "The ID of the Route53 hosted zone"
  type        = string
}

variable "route53_zone_name" {
  description = "The name of the Route53 hosted zone"
  type        = string
}