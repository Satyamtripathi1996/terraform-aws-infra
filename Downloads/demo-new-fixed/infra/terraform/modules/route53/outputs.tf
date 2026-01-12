output "hosted_zone_id" {
  value       = local.hosted_zone_id
  description = "Hosted zone ID used for records"
}

output "hosted_zone_name" {
  value       = var.domain_name
  description = "Hosted zone domain name"
}

output "api_fqdn" {
  value       = var.create_api_record ? "api.${var.domain_name}" : null
  description = "API record name"
}

output "app_fqdn" {
  value       = var.create_frontend_records ? "app.${var.domain_name}" : null
  description = "App record name"
}

output "docs_fqdn" {
  value       = var.create_docs_record ? "docs.${var.domain_name}" : null
  description = "Docs record name"
}
