output "cluster_id" {
  value       = aws_ecs_cluster.this.id
  description = "ECS cluster id"
}

output "service_name" {
  value       = aws_ecs_service.this.name
  description = "ECS service name"
}

output "task_definition_arn" {
  value       = aws_ecs_task_definition.this.arn
  description = "Task definition ARN"
}
