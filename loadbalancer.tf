resource "aws_lb" "lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_security_group.id]
  subnets            = [aws_subnet.public-subnet-1, aws_subnet.public-subnet-2, aws_subnet.public-subnet-3]

  #To store access logins in s3
  #   access_logs {
  #     bucket  = aws_s3_bucket.lb_logs.id
  #     prefix  = "test-lb"
  #     enabled = true
  #   }

  tags = {
    Environment = "production"
  }
}