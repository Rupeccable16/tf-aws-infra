resource "aws_lambda_function" "my_lambda" {
  depends_on    = [aws_sns_topic.user_updates, aws_db_instance.my-db, aws_vpc.csye6225_vpc]
  function_name = var.aws_lambda_function_name
  handler       = var.aws_lambda_function_handler
  runtime       = var.aws_lambda_function_runtime
  role          = aws_iam_role.lambda_role.arn
  s3_bucket     = var.aws_lambda_function_s3bucket
  s3_key        = var.aws_lambda_function_s3key
  #source_code_hash = filebase64sha256("lambda-function.zip") # Ensures new uploads trigger updates
  timeout     = var.aws_lambda_function_timeout # in seconds
  memory_size = var.aws_lambda_function_memory

  logging_config {
    log_format = var.aws_lambda_function_log_format
    log_group  = var.aws_lambda_function_log_group
  }
  # vpc_config {
  #   subnet_ids         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id, aws_subnet.private-subnet-3.id]
  #   security_group_ids = [aws_security_group.lambda_security_group.id]
  # }

  # environment {
  #   variables = {
  #     DB_NAME          = "${var.aws_rds_db_name}",
  #     DB_USER          = "${var.aws_rds_username}",
  #     DB_PASSWORD      = "${data.aws_secretsmanager_secret_version.rds_pass.secret_string}",
  #     DB_HOST          = "${aws_db_instance.my-db.address}"
  #     SENDGRID_API_KEY = "${var.send_grip_api_key}"
  #   }
  # }
}

resource "aws_iam_role" "lambda_role" {
  name = var.aws_lambda_role_name

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
  name = var.aws_lambda_policy_name #var.aws_s3_get_post_delete_list_policy_name
}

data "aws_iam_policy" "lambda_policy_for_secrets" {
  name = var.aws_lambda_policy_for_secrets_name
}

resource "aws_iam_role_policy_attachment" "lambda-policy-attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = data.aws_iam_policy.lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda-secrets-policy-attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = data.aws_iam_policy.lambda_policy_for_secrets.arn
}


resource "aws_iam_instance_profile" "lambda_instance_profile" {
  name = var.aws_lambda_instace_profile_name #var.aws_iam_instance_profile_name
  role = aws_iam_role.lambda_role.name
}
