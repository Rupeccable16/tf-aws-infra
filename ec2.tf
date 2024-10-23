data "aws_ami" "latest_ami" {
  most_recent = true
  owners      = [var.data_ami_owner1, var.data_ami_owner2]
  filter {
    name   = var.data_ami_filter_parameter
    values = [var.data_ami_filter_value]
  }
}



resource "aws_instance" "my-ec2" {
  depends_on                  = [aws_vpc.csye6225_vpc, aws_db_instance.my-db]
  ami                         = data.aws_ami.latest_ami.id
  instance_type               = var.aws_instance_type
  subnet_id                   = aws_subnet.public-subnet-1.id
  associate_public_ip_address = true
  key_name                    = var.aws_instance_key_name

  root_block_device {
    delete_on_termination = true
    volume_size           = var.aws_instance_rootblock_volsize
    volume_type           = var.aws_instance_rootblock_voltype
  }

  disable_api_termination = false

  vpc_security_group_ids = [aws_security_group.application_security_group.id]

  user_data = <<EOF
#!/bin/bash
####################################################
# Configure DB Connection                          #
####################################################
cd /opt/webapp
touch .env

echo "Fetching db details"
PSQL_HOST="${aws_db_instance.my-db.address}" 
PSQL_USER="${var.aws_rds_username}"  
PSQL_PASS="${var.aws_rds_password}"  
PSQL_DBNAME="${var.aws_rds_db_name}" 
PSQL_PORT="${var.psql_port}"

echo "Writing to .env"
{
  echo "PSQL_USER=\"$PSQL_USER\""
  echo "PSQL_HOST=\"$PSQL_HOST\""
  echo "PSQL_PASS=\"$PSQL_PASS\""
  echo "PSQL_DBNAME=\"$PSQL_DBNAME\""
  echo "PORT=\"$PSQL_PORT\""
} >> .env

echo "Changing Ownership"
sudo chown -R csye6225:csye6225 "/opt/webapp/.env"
sudo chmod -R 755 /opt/webapp/.env


EOF

  tags = {
    Name = var.aws_instance_name
  }
}
