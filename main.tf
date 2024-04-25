module "s3" {
    source       = "./modules/s3"
    bucket_name  = "${var.domain_name}-bucket"
}

module "acm" {
    source      = "./modules/acm"
    domain_name = var.domain_name
}

module "cloudfront" {
    source        = "./modules/cloudfront"
    s3_bucket_id  = module.s3.bucket_id
    acm_cert_arn  = module.acm.cert_arn
}

module "route53" {
    source         = "./modules/route53"
    domain_name    = var.domain_name
    cloudfront_dns = module.cloudfront.cf_domain_name
}
