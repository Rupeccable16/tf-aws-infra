resource "aws_lb" "lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_security_group.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id, aws_subnet.public-subnet-3.id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lb_target_grp.arn

  }
}

resource "aws_lb_target_group" "lb_target_grp" {
  name = "lb-target-grp"
  port = 5000
  protocol = "HTTP"
  vpc_id = aws_vpc.csye6225_vpc.id

  health_check {
    path = "/healthz"
    protocol = "HTTP"
    matcher = "200"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }

  tags = {
    name = "LB target group"
  }
}