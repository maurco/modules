resource "aws_s3_bucket" "main" {
  bucket = var.name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = var.noncurrent_expiration
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

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.main.json
}

resource "aws_s3_bucket_object" "index" {
  count        = var.redirect_root == "" ? 0 : 1
  bucket       = aws_s3_bucket.main.id
  key          = "index.html"
  content_type = "text/html"
  content      = var.index_html != "" ? var.index_html : <<EOT
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="refresh" content="0;URL='${var.redirect_root}'" />
</head>
<body>
  <code>Redirecting to ${var.redirect_root}</code>
</body>
</html>
EOT
}

resource "aws_s3_bucket_object" "not_found" {
  bucket       = aws_s3_bucket.main.id
  key          = "404.html"
  content_type = "text/html"
  content      = var.not_found_html != "" ? var.not_found_html : <<EOT
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
