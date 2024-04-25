resource "aws_acm_certificate" "ssl_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn = aws_acm_certificate.ssl_cert.arn

  validation_record_fqdns = [
    aws_route53_record.cert_validation.fqdn
  ]
}
