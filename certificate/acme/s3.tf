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

  dynamic "logging" {
    for_each = var.logs_bucket == "" ? [] : [var.logs_bucket]

    content {
      target_bucket = logging.value
      target_prefix = "AWSLogs/${data.aws_caller_identity.main.account_id}/S3/${var.name}/"
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

resource "aws_s3_bucket_object" "cert" {
  key     = "${local.domain}/cert.pem"
  bucket  = aws_s3_bucket.main.id
  content = acme_certificate.main.certificate_pem
}

resource "aws_s3_bucket_object" "chain" {
  key     = "${local.domain}/chain.pem"
  bucket  = aws_s3_bucket.main.id
  content = acme_certificate.main.issuer_pem
}

resource "aws_s3_bucket_object" "fullchain" {
  key     = "${local.domain}/fullchain.pem"
  bucket  = aws_s3_bucket.main.id
  content = "${acme_certificate.main.certificate_pem}${acme_certificate.main.issuer_pem}"
}

resource "aws_s3_bucket_object" "privkey" {
  key     = "${local.domain}/privkey.pem"
  bucket  = aws_s3_bucket.main.id
  content = tls_private_key.main.private_key_pem
}
