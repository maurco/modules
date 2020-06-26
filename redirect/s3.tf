resource "aws_s3_bucket" "main" {
  bucket        = var.from_domain
  force_destroy = true

  website {
    redirect_all_requests_to = "${var.to_protocol}://${var.to_domain}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.main.json
}
