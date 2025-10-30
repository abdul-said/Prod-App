resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_record_name
  type    = var.alias_record_type

  alias {
    name                   = var.lb_dns_name # this is lb dns name, dynamically fetch this
    zone_id                = var.lb_zone_id # this is the lb zone id, dynamically fetch this
    evaluate_target_health = true
  }
}