resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "rds_secret" {
  name                    = "Secret-for-rds-password1"
  kms_key_id              = aws_kms_key.rds_password_kms_key.id
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = random_password.rds_password.result
}

data "aws_secretsmanager_secret" "by-name" {
  depends_on = [aws_secretsmanager_secret.rds_secret]
  name       = "Secret-for-rds-password1"
}

data "aws_secretsmanager_secret_version" "rds_pass" {
  depends_on = [aws_secretsmanager_secret_version.rds_secret_version]
  secret_id  = data.aws_secretsmanager_secret.by-name.id
}

resource "aws_secretsmanager_secret" "sendgrid_secret" {
  name                    = "sendgrid_api_key1"
  kms_key_id              = aws_kms_key.sendGrid_kms_key.id
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "sendgrid" {
  secret_id     = aws_secretsmanager_secret.sendgrid_secret.id
  secret_string = var.sendgrid_api_key
}