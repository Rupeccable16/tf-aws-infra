resource "aws_iam_role" "ec2_role" {
  name = var.aws_ec2_role

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

data "aws_iam_policy" "s3_policy" {
  name = var.aws_s3_get_post_delete_list_policy_name
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.s3_policy.arn
}

resource "aws_iam_role_policy_attachment" "cloudWatchAgent" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = var.aws_cloudWatchAgent_policy_arn
}

resource "aws_iam_role_policy_attachment" "cloudWatchLogging" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = var.aws_cloudWatchLogging_policy_arn
}

resource "aws_iam_role_policy_attachment" "cloudWatchMetrics" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = var.aws_cloudWatchMetrics_policy_arn
}
