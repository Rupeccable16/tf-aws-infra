data "aws_caller_identity" "current" {}

resource "aws_kms_key" "ec2_kms_key" {
  description             = "A symmetric encryption KMS key"
  enable_key_rotation     = true
  rotation_period_in_days = 90
}

resource "aws_kms_key" "rds_kms_key" {
  description             = "A symmetric encryption KMS key"
  enable_key_rotation     = true
  rotation_period_in_days = 90
}

resource "aws_kms_key" "s3_kms_key" {
  description             = "A symmetric encryption KMS key"
  enable_key_rotation     = true
  rotation_period_in_days = 90
}

resource "aws_kms_key" "rds_password_kms_key" {
  description             = "A symmetric encryption KMS key"
  enable_key_rotation     = true
  rotation_period_in_days = 90
}

resource "aws_kms_key" "sendGrid_kms_key" {
  description             = "A symmetric encryption KMS key"
  enable_key_rotation     = true
  rotation_period_in_days = 90
}

resource "aws_kms_key_policy" "ec2_kms_policy" {
  key_id = aws_kms_key.ec2_kms_key.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "arn:aws:ec2:us-east-1:*"
      }
    ]
  })
}