resource "aws_lambda_function" "my_lambda" {
  depends_on    = [aws_sns_topic.user_updates, aws_db_instance.my-db]
  function_name = "my-lambda-function"
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  role          = aws_iam_role.lambda_role.arn
  s3_bucket     = "serverless-test-rupesh"
  s3_key        = "code3.zip"
  #source_code_hash = filebase64sha256("lambda-function.zip") # Ensures new uploads trigger updates
  timeout     = 900 # in seconds
  memory_size = 128

  logging_config {
    log_format = "Text"
    log_group  = "webappLogs"
  }
  vpc_config {
    subnet_ids         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id, aws_subnet.private-subnet-3.id]
    security_group_ids = [aws_security_group.lambda_security_group.id]
  }

  environment {
    variables = {
      DB_NAME     = "${var.aws_rds_db_name}",
      DB_USER     = "${var.aws_rds_username}",
      DB_PASSWORD = "${var.aws_rds_password}",
      DB_HOST     = "${aws_db_instance.my-db.address}"
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role" #var.aws_ec2_role

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }

}

data "aws_iam_policy" "lambda_policy" {
  name = "lambda-policy" #var.aws_s3_get_post_delete_list_policy_name
}

resource "aws_iam_role_policy_attachment" "lambda-policy-attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = data.aws_iam_policy.lambda_policy.arn
}


resource "aws_iam_instance_profile" "lambda_instance_profile" {
  name = "lambda-instance-profile" #var.aws_iam_instance_profile_name
  role = aws_iam_role.lambda_role.name
}
