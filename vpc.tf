#terraform aws documentation, under VPC -> resources -> aws_vpc, not from data_source
resource "aws_vpc" "csye6225_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "main-vpc"
  }
}