resource "aws_cloudfront_distribution" "main" {
  enabled             = true
  is_ipv6_enabled     = true
  wait_for_deployment = false
  price_class         = var.price_class
  aliases             = concat([var.from_name], var.from_aliases)

  origin {
    origin_id   = "s3-origin"
    domain_name = aws_s3_bucket.main.website_endpoint

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_ssl_protocols   = ["TLSv1"]
      origin_protocol_policy = "http-only"
    }

    custom_header {
      name  = "Referer"
      value = random_password.main.result
    }
  }

  default_cache_behavior {
    target_origin_id       = "s3-origin"
    cached_methods         = ["GET", "HEAD"]
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    viewer_protocol_policy = "allow-all"

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

  dynamic "logging_config" {
    for_each = var.logs_bucket == "" ? [] : [var.logs_bucket]

    content {
      bucket = logging_config.value
      prefix = "AWSLogs/${data.aws_caller_identity.current.account_id}/CloudFront/${var.from_name}/"
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
