resource "aws_route53_record" "www" {
    zone_id = data.aws_route53_zone.primary.zone_id
    name    = var.domain_name
    type    = "A"

    alias {
        name                   = var.cloudfront_dns
        zone_id                = data.aws_route53_zone.primary.zone_id
        evaluate_target_health = true
    }
}
