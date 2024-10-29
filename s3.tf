resource "random_uuid" "uuid" {
}

resource "aws_s3_bucket" "example" {
  bucket = "csye6225-bucket-${random_uuid.uuid.result}" #should be uuid

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

#lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    id = "rule-1"

    transition {
      days          = 90
      storage_class = "STANDARD_IA"
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
      sse_algorithm     = "AES256"
    }
  }

}

#object
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.example.id
  key    = "image-${random_uuid.uuid.result}"  #random uuid for each object

}