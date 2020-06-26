resource "aws_s3_bucket" "main" {
  bucket = var.name
  acl    = "log-delivery-write"

  lifecycle_rule {
    enabled = true

    transition {
      days          = 90 # 3 months
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 365 # one year
      storage_class = "GLACIER"
    }

    transition {
      days          = 730 # two years
      storage_class = "DEEP_ARCHIVE"
    }

    expiration {
      days = 1825 # 5 years
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket                  = aws_s3_bucket.main.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "main" {
  bucket     = aws_s3_bucket.main.bucket
  policy     = data.aws_iam_policy_document.main.json
  depends_on = [aws_s3_bucket_public_access_block.main]
}
