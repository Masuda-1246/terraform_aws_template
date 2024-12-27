resource "aws_lb" "public" {
  name               = "${var.name_prefix}-${var.env}-public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.public_load_balancer_security_group_ids
  subnets            = var.public_subnet_ids

  tags = merge(
    {
      Name = "${var.name_prefix}-${var.env}-public-lb"
    },
    var.tags
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.public.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}

resource "aws_lb_target_group" "http" {
  name     = "${var.name_prefix}-${var.env}-public-http-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = merge(
    {
      Name = "${var.name_prefix}-${var.env}-public-http-tg"
    },
    var.tags
  )
}