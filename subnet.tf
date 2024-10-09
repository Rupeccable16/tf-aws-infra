data "aws_availability_zones" "available" {
  state = var.aws_availability_zones_availability
}

locals {
  subnet_cidrs = cidrsubnets(var.vpc_cidr, var.subnet_additional_bits, var.subnet_additional_bits, var.subnet_additional_bits, var.subnet_additional_bits, var.subnet_additional_bits, var.subnet_additional_bits)
}

resource "aws_subnet" "public-subnet-1" {
  depends_on = [aws_vpc.csye6225_vpc, data.aws_availability_zones.available
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = local.subnet_cidrs[0]
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.public_subnet_1_name
  }
}

resource "aws_subnet" "private-subnet-1" {
  depends_on = [aws_vpc.csye6225_vpc,
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = local.subnet_cidrs[3]
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.private_subnet_1_name
  }
}

resource "aws_subnet" "public-subnet-2" {
  depends_on = [aws_vpc.csye6225_vpc,
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = local.subnet_cidrs[1]
  availability_zone = length(data.aws_availability_zones.available.names) > 1 ? data.aws_availability_zones.available.names[1] : data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.public_subnet_2_name
  }
}

resource "aws_subnet" "private-subnet-2" {
  depends_on = [aws_vpc.csye6225_vpc,
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = local.subnet_cidrs[4]
  availability_zone = length(data.aws_availability_zones.available.names) > 1 ? data.aws_availability_zones.available.names[1] : data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.private_subnet_2_name
  }
}

resource "aws_subnet" "public-subnet-3" {
  depends_on = [aws_vpc.csye6225_vpc,
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = local.subnet_cidrs[2]
  availability_zone = length(data.aws_availability_zones.available.names) > 2 ? data.aws_availability_zones.available.names[2] : data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.public_subnet_3_name
  }
}

resource "aws_subnet" "private-subnet-3" {
  depends_on = [aws_vpc.csye6225_vpc,
  ]

  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = local.subnet_cidrs[5]
  availability_zone = length(data.aws_availability_zones.available.names) > 2 ? data.aws_availability_zones.available.names[2] : data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.private_subnet_3_name
  }
}