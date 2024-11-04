data "aws_ami" "latest_ami" {
  most_recent = true
  owners      = [var.data_ami_owner1, var.data_ami_owner2]
  filter {
    name   = var.data_ami_filter_parameter
    values = [var.data_ami_filter_value]
  }
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = var.aws_iam_instance_profile_name
  role = aws_iam_role.ec2_role.name
}

# resource "aws_instance" "my-ec2" {
#   depends_on                  = [aws_vpc.csye6225_vpc, aws_db_instance.my-db, aws_s3_bucket.example]
#   ami                         = data.aws_ami.latest_ami.id
#   instance_type               = var.aws_instance_type
#   subnet_id                   = aws_subnet.public-subnet-1.id
#   associate_public_ip_address = true
#   key_name                    = var.aws_instance_key_name

#   iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

#   root_block_device {
#     delete_on_termination = true
#     volume_size           = var.aws_instance_rootblock_volsize
#     volume_type           = var.aws_instance_rootblock_voltype
#   }

#   disable_api_termination = false

#   vpc_security_group_ids = [aws_security_group.application_security_group.id]

#   user_data = <<EOF
# #!/bin/bash
# ####################################################
# # Configure DB Connection                          #
# ####################################################
# cd /opt/
# touch .env

# echo "Fetching db details"
# PSQL_HOST="${aws_db_instance.my-db.address}" 
# PSQL_USER="${var.aws_rds_username}"  
# PSQL_PASS="${var.aws_rds_password}"  
# PSQL_DBNAME="${var.aws_rds_db_name}" 
# PSQL_PORT="${var.webapp_port}"
# AWS_BUCKET_NAME="${aws_s3_bucket.example.id}"
# AWS_REGION="${var.region}"

# echo "Writing to .env"
# {
#   echo "PSQL_USER=\"$PSQL_USER\""
#   echo "PSQL_HOST=\"$PSQL_HOST\""
#   echo "PSQL_PASS=\"$PSQL_PASS\""
#   echo "PSQL_DBNAME=\"$PSQL_DBNAME\""
#   echo "PORT=\"$PSQL_PORT\""
#   echo "AWS_BUCKET_NAME=\"$AWS_BUCKET_NAME\""
#   echo "AWS_REGION=\"$AWS_REGION\""
#   echo "ENVIRONMENT=PROD"

# } >> .env

# mv /opt/.env /opt/webapp/.env

# echo "Changing Ownership"
# sudo chown -R csye6225:csye6225 "/opt/webapp/.env"
# sudo chmod -R 755 /opt/webapp/.env

# echo "Waiting for csye6225.service to start..."
# while true; do
#     if systemctl is-active --quiet csye6225.service; then
#         echo "csye6225.service is active."
#         break
#     fi
#     echo "csye6225.service is not yet active. Checking again in 5 seconds..."
#     sleep 5
# done

# echo "Configuring cloudwatch agent"
# sleep 10
# sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
#     -a fetch-config \
#     -m ec2 \
#     -c file:/opt/webapp/cloudWatchConfig/amazon-cloudwatch-agent.json \
#     -s

# EOF

#   tags = {
#     Name = var.aws_instance_name
#   }
# }

#Refer previous AMI and then above ec2 template. Other info not required
resource "aws_launch_template" "ec2_launch_template" {
  name = "ec2-launch-template"

  block_device_mappings {
    device_name = "/dev/sda1" #root block, same in AMI
    ebs {
      volume_size           = "8"
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  # disable_api_stop        = true
  # disable_api_termination = true

  # ebs_optimized = true



  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  image_id = data.aws_ami.latest_ami.id

  instance_initiated_shutdown_behavior = "terminate"

  # instance_market_options {
  #   market_type = "spot"
  # }

  instance_type = var.aws_instance_type

  # kernel_id = "test"

  key_name = var.aws_instance_key_name

  # license_specification {
  #   license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
  # }

  # metadata_options {
  #   http_endpoint               = "enabled"
  #   http_tokens                 = "required"
  #   http_put_response_hop_limit = 1
  #   instance_metadata_tags      = "enabled"
  # }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  lifecycle {
    create_before_destroy = true #Read up more about this
  }

  # placement {
  #   availability_zone = "us-west-2a"       #Who takes care of where the instances are placed, which subnet and what id?
  # }

  # ram_disk_id = "test"

  vpc_security_group_ids = [aws_security_group.application_security_group.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "instance"
    }
  }

  user_data = <<EOF
#!/bin/bash
####################################################
# Configure DB Connection                          #
####################################################
cd /opt/
touch .env

echo "Fetching db details"
PSQL_HOST="${aws_db_instance.my-db.address}" 
PSQL_USER="${var.aws_rds_username}"  
PSQL_PASS="${var.aws_rds_password}"  
PSQL_DBNAME="${var.aws_rds_db_name}" 
PSQL_PORT="${var.webapp_port}"
AWS_BUCKET_NAME="${aws_s3_bucket.example.id}"
AWS_REGION="${var.region}"

echo "Writing to .env"
{
  echo "PSQL_USER=\"$PSQL_USER\""
  echo "PSQL_HOST=\"$PSQL_HOST\""
  echo "PSQL_PASS=\"$PSQL_PASS\""
  echo "PSQL_DBNAME=\"$PSQL_DBNAME\""
  echo "PORT=\"$PSQL_PORT\""
  echo "AWS_BUCKET_NAME=\"$AWS_BUCKET_NAME\""
  echo "AWS_REGION=\"$AWS_REGION\""
  echo "ENVIRONMENT=PROD"

} >> .env

mv /opt/.env /opt/webapp/.env

echo "Changing Ownership"
sudo chown -R csye6225:csye6225 "/opt/webapp/.env"
sudo chmod -R 755 /opt/webapp/.env

echo "Waiting for csye6225.service to start..."
while true; do
    if systemctl is-active --quiet csye6225.service; then
        echo "csye6225.service is active."
        break
    fi
    echo "csye6225.service is not yet active. Checking again in 5 seconds..."
    sleep 5
done

echo "Configuring cloudwatch agent"
sleep 10
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c file:/opt/webapp/cloudWatchConfig/amazon-cloudwatch-agent.json \
    -s

EOF
}
