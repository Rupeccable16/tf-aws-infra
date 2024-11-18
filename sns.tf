resource "aws_sns_topic" "user_updates" {
  name = var.aws_sns_topic_name
}

//Permission to trigger lambda
resource "aws_lambda_permission" "with_sns" {
  statement_id  = var.aws_sns_lambda_permissions_statementID
  action        = var.aws_sns_lambda_permissions_action
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = var.aws_sns_lambda_permissions_principal
  source_arn    = aws_sns_topic.user_updates.arn
}

//Lambda subscription
resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = var.aws_sns_lambda_subscription_protocol
  endpoint  = aws_lambda_function.my_lambda.arn
}


