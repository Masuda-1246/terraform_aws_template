output "zone_id" {
  description = "The ID of the Route53 hosted zone"
  value       = aws_route53_zone.main.id
}

output "zone_name" {
  description = "The name of the Route53 hosted zone"
  value       = aws_route53_zone.main.name
}

output "frontend_domain_name_a_record" {
  description = "The A record of the frontend domain name"
  value       = aws_route53_record.frontend_a_record.name
}