resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "rds_secret" {
  name = "Secret for rds password"
  kms_key_id = aws_kms_key.rds_password_kms_key.id
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = random_password.rds_password.result
}

data "aws_secretsmanager_secret" "by-name" {
  name = "Secret for rds password"
}

data "aws_secretsmanager_secret_version" "rds_pass" {
  secret_id = data.aws_secretsmanager_secret.by-name.id
}