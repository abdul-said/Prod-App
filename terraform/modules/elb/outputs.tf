output "alb_dns_name" {
  value = aws_lb.production.dns_name
}
output "alb_zone_id" {
  value = aws_lb.production.zone_id
}

output "target_group_arn" {
  value = aws_lb_target_group.production.arn 
}