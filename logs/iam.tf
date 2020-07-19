data "aws_iam_policy_document" "main" {
  statement {
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.main.arn]

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com",
        "delivery.logs.amazonaws.com",
      ]
    }
  }

  statement {
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.main.arn}/AWSLogs/*"]

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com",
        "delivery.logs.amazonaws.com",
      ]
    }

    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.main.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}
