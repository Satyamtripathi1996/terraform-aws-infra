output "db_endpoint" {
  value       = aws_db_instance.this.address
  description = "DB endpoint address"
}

output "db_port" {
  value       = aws_db_instance.this.port
  description = "DB port"
}

output "db_name" {
  value       = var.db_name
  description = "DB name"
}

output "db_username" {
  value       = var.db_username
  description = "DB username"
}

output "db_password" {
  value       = var.db_password
  description = "DB password"
  sensitive   = true
}
