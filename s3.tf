resource "random_uuid" "uuid" {
}

resource "aws_s3_bucket" "example" {
  bucket        = "csye6225-bucket-${random_uuid.uuid.result}" #should be uuid
  force_destroy = true
  tags = {
    Name        = var.aws_s3_bucket_tag_name
    Environment = var.aws_s3_bucket_tag_environment
  }
}

#lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    id = var.aws_s3_bucket_rule_id

    transition {
      days          = var.aws_s3_bucket_transition_days
      storage_class = var.aws_s3_bucket_storage_class
    }



    # ... other transition/expiration actions ...

    status = "Enabled"
  }


}

#encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_kms_key.id
      sse_algorithm     = "aws:kms"
    }
  }

}