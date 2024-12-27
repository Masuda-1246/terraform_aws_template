output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC"
}

# output "default_route_table_id" {
#   value       = aws_default_route_table.default.id
#   description = "The ID of the default route table"
# }