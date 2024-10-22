resource "aws_db_subnet_group" "db-subnet-grp" {
  name       = "main"
  subnet_ids = [aws_subnet.private-subnet-1.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "my-db" {
  depends_on        = [aws_vpc.csye6225_vpc] //Add ec2?
  allocated_storage = var.aws_rds_storage


  engine              = var.aws_rds_engine
  engine_version      = var.aws_rds_engine_version
  instance_class      = var.aws_rds_instance_class
  multi_az            = false
  identifier          = var.aws_rds_identifier
  username            = var.aws_rds_username
  password            = var.aws_rds_password
  publicly_accessible = false
  db_name             = var.aws_rds_db_name

  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-grp.name # Copy the subnet group from the RDS Console

  parameter_group_name = "mypostgresparams"
  skip_final_snapshot  = true
}