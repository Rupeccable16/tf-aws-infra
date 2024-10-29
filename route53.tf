resource "aws_route53_record" "dev_subdomain" {
    depends_on = [ aws_instance.my-ec2 ]
  zone_id = "Z01980341MN84QET0LPU9"
  name    = "dev.rupeshrokade.me"
  type    = "A"
  ttl     = 300
  records = [aws_instance.my-ec2.public_ip]
}

resource "aws_route53_record" "demo_subdomain" {
    depends_on = [ aws_instance.my-ec2 ]
  zone_id = "Z01980341MN84QET0LPU9"
  name    = "demo.rupeshrokade.me"
  type    = "A"
  ttl     = 300
  records = [aws_instance.my-ec2.public_ip]
}