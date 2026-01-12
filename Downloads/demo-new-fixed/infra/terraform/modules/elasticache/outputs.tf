locals {
  host = aws_elasticache_replication_group.this.primary_endpoint_address
}

output "redis_host" {
  value       = local.host
  description = "Redis primary endpoint host"
}

output "redis_port" {
  value       = 6379
  description = "Redis port"
}

output "redis_connection_string" {
  value       = "redis://${local.host}:6379"
  description = "Redis connection string"
}
