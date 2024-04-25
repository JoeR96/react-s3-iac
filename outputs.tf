output "s3_bucket_url" {
    value = module.s3.bucket_website_endpoint
}

output "cloudfront_distribution_id" {
    value = module.cloudfront.cf_distribution_id
}

output "cloudfront_distribution_domain_name" {
    value = module.cloudfront.cf_domain_name
}
