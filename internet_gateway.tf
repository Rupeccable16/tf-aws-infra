resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.csye6225_vpc.id

  tags = {
    Name = var.main_internet_gateway_name
  }
}