resource "aws_security_group" "application_security_group" {
  depends_on  = [aws_vpc.csye6225_vpc]
  name        = var.aws_sg_name1
  description = var.aws_sg_description
  vpc_id      = aws_vpc.csye6225_vpc.id

  tags = {
    Name = var.aws_sg_name2
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh" {
  security_group_id = aws_security_group.application_security_group.id
  cidr_ipv4         = var.internet_cidr
  ip_protocol       = var.ip_protocol_1
  from_port         = var.ssh_port
  to_port           = var.ssh_port
}

resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.application_security_group.id
  cidr_ipv4         = var.internet_cidr
  ip_protocol       = var.ip_protocol_1
  from_port         = var.http_port
  to_port           = var.http_port
}

resource "aws_vpc_security_group_ingress_rule" "allow-https" {
  security_group_id = aws_security_group.application_security_group.id
  cidr_ipv4         = var.internet_cidr
  ip_protocol       = var.ip_protocol_1
  from_port         = var.https_port
  to_port           = var.https_port
}

resource "aws_vpc_security_group_ingress_rule" "allow-webapp" {
  security_group_id = aws_security_group.application_security_group.id
  cidr_ipv4         = var.internet_cidr
  ip_protocol       = var.ip_protocol_1
  from_port         = var.webapp_port
  to_port           = var.webapp_port
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_traffic" {
  security_group_id = aws_security_group.application_security_group.id
  cidr_ipv4         = var.internet_cidr
  ip_protocol       = var.ip_protocol_2
}