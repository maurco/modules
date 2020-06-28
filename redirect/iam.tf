data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "main" {
  statement {
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.main.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
