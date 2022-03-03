resource "aws_lb" "webapp_alb" {
  name               = "${var.application_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_security_group.id]
  subnets = [for subnet in module.network.subnet_ids: subnet.subnet_id]

  enable_deletion_protection = false

  tags = {
    Environment = var.application_name
  }
}

resource "aws_lb_target_group" "webapp_tg" {
  name     = "${var.application_name}-lb-tg"
  port     = var.backend_port
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    interval = 10
  }

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.webapp_alb.arn
  port              = var.frontend_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp_tg.arn
  }
}