resource "aws_placement_group" "test" {
  name     = "test"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "autoscaler_grp" {
  depends_on                = [aws_launch_template.ec2_launch_template]
  name                      = "csye6225_asg"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  default_instance_warmup   = 300
  health_check_type         = "ELB" #Unsure what to choose here - https://aws.amazon.com/blogs/networking-and-content-delivery/choosing-the-right-health-check-with-elastic-load-balancing-and-ec2-auto-scaling/
  desired_capacity          = 1
  #   placement_group           = aws_placement_group.test.id
  vpc_zone_identifier = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id, aws_subnet.public-subnet-3.id]

  launch_template {
    id = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }

  #   instance_maintenance_policy {
  #     min_healthy_percentage = 90
  #     max_healthy_percentage = 120
  #   }

  #   initial_lifecycle_hook {
  #     name                 = "foobar"
  #     default_result       = "CONTINUE"
  #     heartbeat_timeout    = 2000
  #     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

  #     notification_metadata = jsonencode({
  #       foo = "bar"
  #     })

  #     notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
  #     role_arn                = "arn:aws:iam::123456789012:role/S3Access"
  #   }

  tag {
    key                 = "name"
    value               = "webapp-instance"
    propagate_at_launch = true
  }

  #   timeouts {
  #     delete = "15m"
  #   }

  #   tag {
  #     key                 = "lorem"
  #     value               = "ipsum"
  #     propagate_at_launch = false
  #   }
}

resource "aws_autoscaling_attachment" "attach_autoscaler_and_loadbalancer" {
  autoscaling_group_name = aws_autoscaling_group.autoscaler_grp.name
  lb_target_group_arn    = aws_lb_target_group.lb_target_grp.arn
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "aws-autoscaler-policy-scale-up"
  autoscaling_group_name = aws_autoscaling_group.autoscaler_grp.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "aws-autoscaler-policy-scale-down"
  autoscaling_group_name = aws_autoscaling_group.autoscaler_grp.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 60
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_description   = "scale down when CPU < 3%"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  alarm_name          = "scale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "3"
  evaluation_periods  = "1"
  period              = "60"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaler_grp.name
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_description   = "scale up when CPU > 5%"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  alarm_name          = "scale_up"
  comparison_operator = "GreaterThanThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "5"
  evaluation_periods  = "1"  #no of eval periods. Performs scale up when the avg cpu util is > than threshold for one 60 second long period. (can be kept to x periods of y duration)
  period              = "60" #eval periods duration
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaler_grp.name
  }
}
