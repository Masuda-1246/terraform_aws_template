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

variable "repository_type" {
  description = "Type of repository (frontend or backend)"
  type        = string
  default     = "frontend"
}
variable "tags" {
  description = "Tags for the ecr resource"
  type        = map(string)
  default     = {}
}