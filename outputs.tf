output "s3_bucket_name" {
  value = aws_s3_bucket.react_app.bucket
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.react_app_cf.id
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.react_app_cf.domain_name
}
