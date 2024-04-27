resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "ns_record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "${var.domain_name}"
  type    = "NS"
  ttl     = 172800

  records = var.nameservers
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

resource "aws_route53_record" "cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.primary.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}
