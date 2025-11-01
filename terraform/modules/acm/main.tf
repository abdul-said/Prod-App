resource "aws_acm_certificate" "production" {
  domain_name       = var.domain_name
  subject_alternative_names = var.subdomain_name
  validation_method = var.acm_validation_mehod
}

# data "aws_route53_zone" "primary" {
#   name         = var.domain_name
#   private_zone = false
# }

resource "aws_route53_record" "validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.production.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

resource "aws_acm_certificate_validation" "production" {
  certificate_arn         = aws_acm_certificate.production.arn
  validation_record_fqdns = [for record in aws_route53_record.validation_record : record.fqdn]
}