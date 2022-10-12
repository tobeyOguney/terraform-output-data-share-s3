resource "aws_s3_bucket" "data_share_bucket" {
  bucket = var.bucket_name

  tags = {
    "Name" = var.bucket_name
  }
}

resource "aws_s3_bucket_policy" "data_share_bucket_policy" {
  bucket = aws_s3_bucket.data_share_bucket.id

  policy = data.aws_iam_document.data_share_bucket_policy.json
}

resource "aws_s3_bucket_public_access_block" "data_share_bucket_public_access_block" {
  bucket = aws_s3_bucket.data_share_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_server_side_encryption_configuration" "data_share_bucket_encryption" {
  bucket = aws_s3_bucket.data_share_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}