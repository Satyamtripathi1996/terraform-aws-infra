output "hosted_zone_id" {
  value = module.route53_zone.hosted_zone_id
}

output "api_url" {
  value = "https://api.${var.domain_name}"
}

output "frontend_url" {
  value = "https://${var.domain_name}"
}

output "docs_url" {
  value = "https://docs.${var.domain_name}"
}

output "alb_dns" {
  value = module.alb.alb_dns_name
}
