data "aws_ami" "latest_ami" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["csye6225_app_*"]
  }
}



resource "aws_instance" "my-ec2" {
  depends_on                  = [aws_vpc.csye6225_vpc]
  ami                         = data.aws_ami.latest_ami.id
  instance_type               = "t2.small"
  subnet_id                   = aws_subnet.public-subnet-1.id
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true
    volume_size           = 25
    volume_type           = "gp2"
  }

  disable_api_termination = false

  vpc_security_group_ids = [aws_security_group.application_security_group.id]

  tags = {
    Name = "my-ec2"
  }
}
