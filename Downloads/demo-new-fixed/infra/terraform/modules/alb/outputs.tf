output "alb_arn" {
  value       = aws_lb.this.arn
  description = "ALB ARN"
}

output "alb_dns_name" {
  value       = aws_lb.this.dns_name
  description = "ALB DNS name (use for Route53 alias)"
}

output "alb_zone_id" {
  value       = aws_lb.this.zone_id
  description = "ALB hosted zone ID (use for Route53 alias)"
}

output "target_group_arn" {
  value       = aws_lb_target_group.app_tg.arn
  description = "Target group ARN (ECS service attaches here)"
}

output "https_listener_arn" {
  value       = aws_lb_listener.https.arn
  description = "HTTPS listener ARN"
}
