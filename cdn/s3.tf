resource "aws_s3_bucket" "main" {
  bucket = var.domain
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = var.noncurrent_version_expiration
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.main.json
}

resource "aws_s3_bucket_object" "index" {
  count        = var.redirect_root_to == "" ? 0 : 1
  bucket       = aws_s3_bucket.main.id
  key          = "index.html"
  content_type = "text/html"
  content      = <<EOT
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="refresh" content="0;URL='${var.redirect_root_to}'" />
</head>
<body>
  <code>Redirecting to ${var.redirect_root_to}</code>
</body>
</html>
EOT
}

resource "aws_s3_bucket_object" "not_found" {
  bucket       = aws_s3_bucket.main.id
  key          = "404.html"
  content_type = "text/html"
  content      = <<EOT
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>Not Found</title>
</head>
<body>
  <code>Not Found</code>
</body>
</html>
EOT
}
