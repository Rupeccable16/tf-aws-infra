resource "aws_lb" "lb" {
  name               = var.aws_lb_name
  internal           = false
  load_balancer_type = var.aws_lb_type
  security_groups    = [aws_security_group.load_balancer_security_group.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id, aws_subnet.public-subnet-3.id]

  tags = {
    Environment = var.aws_lb_tag_env
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.aws_lb_listener_port
  protocol          = var.aws_lb_listener_protocol
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:209479307750:certificate/7ba245c5-6739-42c7-8ba9-4da3c128df2e"

  default_action {
    type             = var.aws_lb_listener_default_action_type
    target_group_arn = aws_lb_target_group.lb_target_grp.arn

  }
}

resource "aws_lb_target_group" "lb_target_grp" {
  name       = var.aws_lb_targetgrp_name
  port       = var.aws_lb_targetgrp_port
  protocol   = var.aws_lb_targetgrp_protocol
  vpc_id     = aws_vpc.csye6225_vpc.id
  slow_start = var.aws_lb_targetgrp_slowstart

  health_check {
    path                = var.aws_lb_targetgrp_health_path
    matcher             = var.aws_lb_targetgrp_health_matcher
    interval            = var.aws_lb_targetgrp_health_interval
    timeout             = var.aws_lb_targetgrp_health_timeout
    healthy_threshold   = var.aws_lb_targetgrp_health_healthy_threshold
    unhealthy_threshold = var.aws_lb_targetgrp_health_unhealthy_threshold
  }

  tags = {
    name = var.aws_lb_targetgrp_tag_name
  }
}