resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.csye6225_vpc.id

  tags = {
    Name = var.main_internet_gateway_name
  }
}

resource "aws_eip" "eip1" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_pub_1" {
  allocation_id = aws_eip.eip1.allocation_id
  subnet_id     = aws_subnet.public-subnet-1.id
}
