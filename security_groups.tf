resource "aws_security_group" "application_security_group" {
  depends_on  = [aws_vpc.csye6225_vpc]
  name        = var.aws_sg_name1
  description = var.aws_sg_description
  vpc_id      = aws_vpc.csye6225_vpc.id

  tags = {
    Name = var.aws_sg_name2
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_loadbalancer" {
  depends_on                   = [aws_security_group.load_balancer_security_group]
  security_group_id            = aws_security_group.application_security_group.id
  referenced_security_group_id = aws_security_group.load_balancer_security_group.id
  ip_protocol                  = var.ip_protocol_1
  from_port                    = var.ssh_port
  to_port                      = var.ssh_port
}

resource "aws_vpc_security_group_ingress_rule" "allow_webapp_from_loadbalancer" {
  security_group_id            = aws_security_group.application_security_group.id
  referenced_security_group_id = aws_security_group.load_balancer_security_group.id
  ip_protocol                  = var.ip_protocol_1
  from_port                    = var.webapp_port
  to_port                      = var.webapp_port
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_internet" {
  # depends_on                   = [aws_security_group.load_balancer_security_group]
  security_group_id = aws_security_group.application_security_group.id
  # referenced_security_group_id = aws_security_group.load_balancer_security_group.id
  ip_protocol = var.ip_protocol_1
  from_port   = var.ssh_port
  to_port     = var.ssh_port
  cidr_ipv4   = var.internet_cidr
}

#Restricting access to webapp directly from internet, hence commented the code below
# resource "aws_vpc_security_group_ingress_rule" "allow-https" {
#   security_group_id = aws_security_group.application_security_group.id
#   cidr_ipv4         = var.internet_cidr
#   ip_protocol       = var.ip_protocol_1
#   from_port         = var.https_port
#   to_port           = var.https_port
# }

# resource "aws_vpc_security_group_ingress_rule" "allow-webapp" {
#   security_group_id = aws_security_group.application_security_group.id
#   cidr_ipv4         = var.internet_cidr
#   ip_protocol       = var.ip_protocol_1
#   from_port         = var.webapp_port
#   to_port           = var.webapp_port
# }

#Commenting this as my webapp can communicate within the same vpc w/o explicit egress rule
resource "aws_vpc_security_group_egress_rule" "allow_outbound_traffic" {
  security_group_id = aws_security_group.application_security_group.id
  cidr_ipv4         = var.internet_cidr
  ip_protocol       = var.ip_protocol_2
}

resource "aws_security_group" "database_security_group" {
  depends_on  = [aws_vpc.csye6225_vpc]
  name        = var.aws_sg_rds_name1
  description = var.aws_sg_rds_description
  vpc_id      = aws_vpc.csye6225_vpc.id

  tags = {
    Name = var.aws_sg_rds_name2
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow-webapp-to-rds" {
  security_group_id            = aws_security_group.database_security_group.id
  referenced_security_group_id = aws_security_group.application_security_group.id
  #cidr_ipv4         = aws_instance.my-ec2.private_ip #Connection only from the ec2's private ipv4
  ip_protocol = var.ip_protocol_1
  from_port   = var.db_psql_port
  to_port     = var.db_psql_port
}

#Commenting this as my rds can communicate within the same vpc, and thus can talk to the webapp
resource "aws_vpc_security_group_egress_rule" "allow-rds-out" {
  security_group_id = aws_security_group.database_security_group.id
  cidr_ipv4         = var.internet_cidr
  ip_protocol       = var.ip_protocol_2
}

resource "aws_security_group" "load_balancer_security_group" {
  depends_on  = [aws_vpc.csye6225_vpc]
  name        = var.aws_sg_loadbalancer_name1
  description = var.aws_sg_loadbalancer_description
  vpc_id      = aws_vpc.csye6225_vpc.id

  tags = {
    Name = var.aws_sg_loadbalancer_name2
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow-internet-to-loadbalancer_port1" {
  security_group_id = aws_security_group.load_balancer_security_group.id
  cidr_ipv4         = var.internet_cidr
  from_port         = 80
  to_port           = 80
  ip_protocol       = var.ip_protocol_1
}

resource "aws_vpc_security_group_ingress_rule" "allow-internet-to-loadbalancer_port2" {
  security_group_id = aws_security_group.load_balancer_security_group.id
  cidr_ipv4         = var.internet_cidr
  from_port         = 443
  to_port           = 443
  ip_protocol       = var.ip_protocol_1
}

resource "aws_vpc_security_group_egress_rule" "allow_loadbalancer_out" {
  security_group_id = aws_security_group.load_balancer_security_group.id
  cidr_ipv4         = var.internet_cidr
  ip_protocol       = var.ip_protocol_2
}