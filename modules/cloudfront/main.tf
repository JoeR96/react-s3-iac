resource "aws_cloudfront_distribution" "s3_distribution" {
    origin {
        domain_name = var.s3_bucket_id
        origin_id   = "S3-${var.domain_name}"
    }

    enabled             = true
    default_root_object = "index.html"

    aliases = [var.domain_name]

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD"]
        target_origin_id = "S3-${var.domain_name}"

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    viewer_certificate {
        acm_certificate_arn = var.acm_cert_arn
        ssl_support_method  = "sni-only"
        minimum_protocol_version = "TLSv1.2_2019"
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }
}
