resource "aws_cloudfront_distribution" "main" {
  enabled             = true
  is_ipv6_enabled     = true
  wait_for_deployment = false
  price_class         = var.price_class
  aliases             = [var.name]

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
    viewer_protocol_policy = "redirect-to-https"
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

  dynamic "logging_config" {
    for_each = var.logs_bucket == "" ? [] : [var.logs_bucket]

    content {
      bucket = logging_config.value
      prefix = "AWSLogs/${data.aws_caller_identity.current.account_id}/CloudFront/${var.name}/"
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code         = 400
    response_code      = 404
    response_page_path = var.not_found_page
  }

  custom_error_response {
    error_code         = 403
    response_code      = 404
    response_page_path = var.not_found_page
  }

  custom_error_response {
    error_code            = 404
    response_code         = var.app_page == "" ? 404 : 200
    response_page_path    = var.app_page == "" ? var.not_found_page : var.app_page
    error_caching_min_ttl = var.app_page == "" ? 10 : 31536000
  }

  custom_error_response {
    error_code         = 405
    response_code      = 404
    response_page_path = var.not_found_page
  }

  custom_error_response {
    error_code         = 414
    response_code      = 404
    response_page_path = var.not_found_page
  }

  custom_error_response {
    error_code         = 416
    response_code      = 404
    response_page_path = var.not_found_page
  }

  custom_error_response {
    error_code         = 500
    response_code      = 500
    response_page_path = var.error_page
  }

  custom_error_response {
    error_code         = 501
    response_code      = 500
    response_page_path = var.error_page
  }

  custom_error_response {
    error_code         = 502
    response_code      = 500
    response_page_path = var.error_page
  }

  custom_error_response {
    error_code         = 503
    response_code      = 500
    response_page_path = var.error_page
  }

  custom_error_response {
    error_code         = 504
    response_code      = 500
    response_page_path = var.error_page
  }

  lifecycle {
    create_before_destroy = true
  }
}
