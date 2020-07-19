resource "aws_s3_bucket" "main" {
  bucket = var.name
  acl    = "log-delivery-write"

  lifecycle_rule {
    enabled = true

    transition {
      days          = var.standard_ia
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.glacier
      storage_class = "GLACIER"
    }

    transition {
      days          = var.deep_archive
      storage_class = "DEEP_ARCHIVE"
    }

    expiration {
      days = var.expiration
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
