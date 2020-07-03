data "aws_caller_identity" "current" {}

resource "aws_cloudfront_origin_access_identity" "main" {
  comment = var.domain
}

resource "aws_cloudfront_distribution" "main" {
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  aliases             = [var.domain]
  default_root_object = length(aws_s3_bucket_object.index) > 0 ? aws_s3_bucket_object.index[0].id : null
  wait_for_deployment = false

  origin {
    origin_id   = "s3-origin"
    domain_name = aws_s3_bucket.main.bucket_regional_domain_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = "s3-origin"
    cached_methods         = ["GET", "HEAD"]
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {
    path_pattern           = "${var.private_prefix}/*"
    target_origin_id       = "s3-origin"
    cached_methods         = ["GET", "HEAD"]
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    viewer_protocol_policy = "redirect-to-https"
    trusted_signers        = ["self"]
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = "sni-only"
  }

  logging_config {
    bucket = var.logs_bucket
    prefix = "AWSLogs/${data.aws_caller_identity.current.account_id}/CloudFront/${var.domain}/"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code         = 403
    response_code      = 404
    response_page_path = "/${aws_s3_bucket_object.not_found.id}"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/${aws_s3_bucket_object.not_found.id}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
