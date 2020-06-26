resource "aws_cloudtrail" "main" {
  name                          = var.name
  s3_bucket_name                = aws_s3_bucket.main.id
  is_multi_region_trail         = true
  include_global_service_events = true
  enable_log_file_validation    = true
  depends_on                    = [aws_s3_bucket_policy.main]
}
