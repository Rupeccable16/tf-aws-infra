# resource "aws_route53_record" "dev_subdomain" {
#     depends_on = [ aws_instance.my-ec2 ]
#   zone_id = "Z01980341MN84QET0LPU9"
#   name    = "dev.rupeshrokade.me"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.my-ec2.public_ip]
# }

data "aws_route53_zone" "curr_acc_zone" {
  zone_id = var.aws_route53_curr_acc_zone_id
}

resource "aws_route53_record" "demo_subdomain" {
    depends_on = [ aws_instance.my-ec2 ]
  zone_id = var.aws_route53_demo_acc_zone_id
  name    = var.aws_route53_demo_subdomain_name
  type    = var.aws_route53_demo_subdomain_record_type
  ttl     = var.aws_route53_demo_subdomain_record_ttl
  records = [aws_instance.my-ec2.public_ip]
}