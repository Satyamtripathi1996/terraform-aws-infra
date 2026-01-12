variable "app_name" {
  description = "App name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "aws_region" {
  description = "AWS region (for logs)"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
  default     = "api"
}

variable "container_port" {
  description = "Container port"
  type        = number
  default     = 8000
}

variable "image" {
  description = "Container image (e.g. <repo_url>:latest)"
  type        = string
}

variable "cpu" {
  description = "Task CPU (Fargate). Example: 256/512/1024/2048"
  type        = string
  default     = "512"
}

variable "memory" {
  description = "Task memory (Fargate). Example: 1024/2048/4096"
  type        = string
  default     = "1024"
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 1
}

variable "ecs_task_execution_role_arn" {
  description = "Execution role ARN"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "Task role ARN"
  type        = string
}

variable "environment_variables" {
  description = "Plain environment variables for the container"
  type        = list(object({ name = string, value = string }))
  default     = []
}

variable "secrets" {
  description = "Secrets Manager variables for the container"
  type        = list(object({ name = string, valueFrom = string }))
  default     = []
}

variable "log_retention_days" {
  description = "CloudWatch log retention"
  type        = number
  default     = 7
}

variable "capacity_provider" {
  description = "ECS capacity provider: FARGATE or FARGATE_SPOT"
  type        = string
  default     = "FARGATE"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
