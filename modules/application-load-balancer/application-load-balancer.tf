resource "aws_lb_target_group" "main" {
  name        = "${var.name}-alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  health_check {
    path = "/"
    port = "80"
    protocol = "HTTP"
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 10
    timeout = 5
    matcher = "200-399"
  }
  tags = {
    Name = "${var.name}-alb-tg"
  }
}

resource "aws_lb_target_group_attachment" "main" {
  count = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
}

resource "aws_lb" "main" {
  name               = "${var.name}-alb"
  internal           = false
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = [for subnet in var.subnets : subnet]
  enable_deletion_protection = var.enable_deletion_protection

  access_logs {
    enabled = var.access_logs.enabled
    bucket  = var.access_logs.name
    prefix  = var.access_logs.prefix
  }

  tags = var.tags
}

resource "aws_lb_listener" "main" {
  count = length(var.listeners)
  load_balancer_arn = aws_lb.main.arn
  port              = var.listeners[count.index].port
  protocol          = var.listeners[count.index].protocol
  default_action {
    type             = var.listeners[count.index].action.type
    target_group_arn = aws_lb_target_group.main.arn
  }
}