resource "aws_placement_group" "test" {
  name     = "test"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "autoscaler_grp" {
  depends_on                = [aws_launch_template.ec2_launch_template]
  name                      = var.aws_asg_name
  max_size                  = var.aws_asg_max_size
  min_size                  = var.aws_asg_min_size
  health_check_grace_period = var.aws_asg_healthcheck_grace_period
  default_instance_warmup   = var.aws_asg_default_instance_warmup
  health_check_type         = var.aws_asg_healthcheck_type
  desired_capacity          = var.aws_asg_desired_capacity

  vpc_zone_identifier = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id, aws_subnet.public-subnet-3.id]

  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = var.aws_asg_tag_name
    value               = var.aws_asg_tag_value
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "attach_autoscaler_and_loadbalancer" {
  autoscaling_group_name = aws_autoscaling_group.autoscaler_grp.name
  lb_target_group_arn    = aws_lb_target_group.lb_target_grp.arn
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = var.aws_asg_scaleup_policy_name
  autoscaling_group_name = aws_autoscaling_group.autoscaler_grp.name
  adjustment_type        = var.aws_asg_scaleup_policy_adjtype
  scaling_adjustment     = var.aws_asg_scaleup_policy_scaleadj
  cooldown               = var.aws_asg_scaleup_policy_cooldown
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = var.aws_asg_scaledown_policy_name
  autoscaling_group_name = aws_autoscaling_group.autoscaler_grp.name
  adjustment_type        = var.aws_asg_scaledown_policy_adjtype
  scaling_adjustment     = var.aws_asg_scaledown_policy_scaleadj
  cooldown               = var.aws_asg_scaledown_policy_cooldown
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_description   = var.aws_asg_cw_scaledown_alarm_description
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  alarm_name          = var.aws_asg_cw_scaledown_alarm_name
  comparison_operator = var.aws_asg_cw_scaledown_alarm_comp_operator
  namespace           = var.aws_asg_cw_scaledown_alarm_namespace
  metric_name         = var.aws_asg_cw_scaledown_alarm_metric_name
  threshold           = var.aws_asg_cw_scaledown_alarm_metric_threshold
  evaluation_periods  = var.aws_asg_cw_scaledown_alarm_metric_evalperiods
  period              = var.aws_asg_cw_scaledown_alarm_metric_period
  statistic           = var.aws_asg_cw_scaledown_alarm_metric_statistic

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaler_grp.name
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_description   = var.aws_asg_cw_scaleup_alarm_description
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  alarm_name          = var.aws_asg_cw_scaleup_alarm_name
  comparison_operator = var.aws_asg_cw_scaleup_alarm_comp_operator
  namespace           = var.aws_asg_cw_scaleup_alarm_namespace
  metric_name         = var.aws_asg_cw_scaleup_alarm_metric_name
  threshold           = var.aws_asg_cw_scaleup_alarm_metric_threshold
  evaluation_periods  = var.aws_asg_cw_scaleup_alarm_metric_evalperiods #no of eval periods. Performs scale up when the avg cpu util is > than threshold for one 60 second long period. (can be kept to x periods of y duration)
  period              = var.aws_asg_cw_scaleup_alarm_metric_period      #eval periods duration
  statistic           = var.aws_asg_cw_scaleup_alarm_metric_statistic

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaler_grp.name
  }
}
