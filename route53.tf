resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "root_record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.react_app_cf.domain_name
    zone_id                = aws_cloudfront_distribution.react_app_cf.hosted_zone_id
    evaluate_target_health = true
  }
}