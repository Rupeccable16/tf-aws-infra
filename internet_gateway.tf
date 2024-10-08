resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.csye6225_vpc.id

  tags = {
    Name = "main-internet-gateway"
  }
}