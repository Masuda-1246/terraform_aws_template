resource "aws_vpc" "main" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name        = "${var.name_prefix}-${var.env}-vpc"
    name_prefix = var.name_prefix
    env         = var.env
  }
}

# resource "aws_default_route_table" "default" {
#   default_route_table_id = aws_vpc.main.default_route_table_id
#   tags = merge(
#     {
#       Name = "${var.name_prefix}-${var.env}-default-rt"
#     },
#     var.tags
#   )
# }

# resource "aws_route" "default_internet_access" {
#   route_table_id         = aws_default_route_table.default.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.main.id
#   depends_on             = [aws_internet_gateway.main]
# }


# resource "aws_vpc_endpoint" "cloudwatch_logs" {
#   vpc_id             = aws_vpc.vpc.id
#   service_name       = "com.amazonaws.ap-northeast-1.logs"
#   vpc_endpoint_type  = "Interface"
#   subnet_ids         = [aws_subnet.private_subnet_1c.id, aws_subnet.private_subnet_1d.id]
#   security_group_ids = [aws_security_group.vpc_endpoint.id]
# }

# resource "aws_security_group" "vpc_endpoint" {
#   name   = "${var.name_prefix}-${var.env}-vpc-endpoint-sg"
#   vpc_id = aws_vpc.vpc.id

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [aws_vpc.vpc.cidr_block]
#   }

#   tags = {
#     Name        = "${var.name_prefix}-${var.env}-vpc-endpoint-sg"
#     name_prefix = var.name_prefix
#     env         = var.env
#   }
# }
