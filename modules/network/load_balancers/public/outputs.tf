output "public_load_balancer_arn" {
  description = "The ARN of the public load balancer"
  value       = aws_lb.public.arn
}

output "public_load_balancer_target_group_arn" {
  description = "The ARN of public load balancer target group"
  value       = aws_lb_target_group.http.arn
}

output "public_load_balancer_dns_name" {
  description = "The DNS name of the public load balancer"
  value       = aws_lb.public.dns_name
}

output "public_load_balancer_zone_id" {
  description = "The HostedZone ID of the public load balancer"
  value       = aws_lb.public.zone_id
}
