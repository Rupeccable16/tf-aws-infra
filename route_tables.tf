resource "aws_route_table" "public_subnet_route_table" {
  depends_on = [aws_vpc.csye6225_vpc, aws_internet_gateway.gw]
  vpc_id     = aws_vpc.csye6225_vpc.id

  route {
    cidr_block = var.internet_cidr
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route_table" "private_subnet_route_table" {
  depends_on = [aws_vpc.csye6225_vpc]
  vpc_id     = aws_vpc.csye6225_vpc.id

  route {
    cidr_block     = var.internet_cidr
    nat_gateway_id = aws_nat_gateway.nat_pub_1.id
  }


  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route_table_association" "a" {
  depends_on     = [aws_subnet.public-subnet-1]
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

resource "aws_route_table_association" "b" {
  depends_on     = [aws_subnet.public-subnet-2]
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

resource "aws_route_table_association" "c" {
  depends_on     = [aws_subnet.public-subnet-3]
  subnet_id      = aws_subnet.public-subnet-3.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

resource "aws_route_table_association" "d" {
  depends_on     = [aws_subnet.private-subnet-1]
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private_subnet_route_table.id
}

resource "aws_route_table_association" "e" {
  depends_on     = [aws_subnet.private-subnet-2]
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private_subnet_route_table.id
}

resource "aws_route_table_association" "f" {
  depends_on     = [aws_subnet.private-subnet-3]
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private_subnet_route_table.id
}
