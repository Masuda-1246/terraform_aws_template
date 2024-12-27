resource "aws_route53_zone" "main" {
  name          = var.domain_name
  force_destroy = false

  tags = merge(
    {
      Name = "${var.name_prefix}-${var.env}-route53-zone"
    },
    var.tags
  )
}

resource "aws_route53_record" "frontend_a_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.frontend_domain_name
  type    = "A"
  alias {
    name                   = var.public_load_balancer_dns_name
    zone_id                = var.public_load_balancer_zone_id
    evaluate_target_health = true
  }
}