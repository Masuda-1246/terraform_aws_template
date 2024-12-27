output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = { for key, subnet in aws_subnet.public : key => subnet.id }
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = { for key, subnet in aws_subnet.private : key => subnet.id }
}