resource "aws_subnet" "public-subnet-1" {
  depends_on = [aws_vpc.csye6225_vpc,
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-1" {
  depends_on = [aws_vpc.csye6225_vpc,
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  depends_on = [aws_vpc.csye6225_vpc,
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-2" {
  depends_on = [aws_vpc.csye6225_vpc,
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_subnet" "public-subnet-3" {
  depends_on = [aws_vpc.csye6225_vpc,
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = var.public_subnet_3_cidr
  availability_zone = var.availability_zone_3

  tags = {
    Name = "public-subnet-3"
  }
}

resource "aws_subnet" "private-subnet-3" {
  depends_on = [aws_vpc.csye6225_vpc,
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = var.private_subnet_3_cidr
  availability_zone = var.availability_zone_3

  tags = {
    Name = "private-subnet-3"
  }
}