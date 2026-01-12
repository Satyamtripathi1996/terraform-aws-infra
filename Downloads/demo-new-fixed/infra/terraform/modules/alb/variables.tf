variable "app_name" {
  description = "App name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security group ID for ALB"
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener (regional cert)"
  type        = string
}

variable "app_port" {
  description = "Backend container port (target group port)"
  type        = number
  default     = 8000
}

variable "health_check_path" {
  description = "Health check path for target group"
  type        = string
  default     = "/health"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
