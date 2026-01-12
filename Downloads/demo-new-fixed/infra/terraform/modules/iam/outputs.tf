output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution.arn
  description = "ECS task execution role ARN"
}

output "ecs_task_role_arn" {
  value       = aws_iam_role.ecs_task.arn
  description = "ECS task role ARN"
}
