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
