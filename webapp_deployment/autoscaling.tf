resource "aws_autoscaling_group" "webapp_asg" {
  vpc_zone_identifier = [for subnet in module.network.subnet_ids: subnet.subnet_id]
  desired_capacity   = var.autoscaling.desired
  max_size           = var.autoscaling.max
  min_size           = var.autoscaling.min
  target_group_arns = [aws_lb_target_group.webapp_tg.arn]

  tag {
    key                 = "Name"
    value               = "${var.application_name}-worker"
    propagate_at_launch = true
  }

  instance_refresh{
    strategy = "Rolling"

  }

  launch_configuration = aws_launch_configuration.as_conf.name
}
