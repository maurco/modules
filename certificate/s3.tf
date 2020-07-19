resource "aws_s3_bucket" "main" {
  bucket = var.name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = 90
    }
  }

  logging {
    target_bucket = var.logs_bucket
    target_prefix = "AWSLogs/${data.aws_caller_identity.main.account_id}/S3/${var.name}/"
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

resource "aws_s3_bucket_object" "cert" {
  bucket  = aws_s3_bucket.main.id
  key     = "cert.pem"
  content = acme_certificate.main.certificate_pem
}

resource "aws_s3_bucket_object" "chain" {
  bucket  = aws_s3_bucket.main.id
  key     = "chain.pem"
  content = acme_certificate.main.issuer_pem
}

resource "aws_s3_bucket_object" "fullchain" {
  bucket  = aws_s3_bucket.main.id
  key     = "fullchain.pem"
  content = "${acme_certificate.main.certificate_pem}${acme_certificate.main.issuer_pem}"
}

resource "aws_s3_bucket_object" "privkey" {
  bucket  = aws_s3_bucket.main.id
  key     = "privkey.pem"
  content = tls_private_key.main.private_key_pem
}
