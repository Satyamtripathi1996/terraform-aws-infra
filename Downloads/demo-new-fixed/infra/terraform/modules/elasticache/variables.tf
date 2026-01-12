variable "app_name" { type = string }
variable "environment" { type = string }

variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }

variable "ecs_sg_id" {
  description = "ECS security group allowed to access Redis"
  type        = string
}

variable "node_type" {
  description = "Redis node type"
  type        = string
  default     = "cache.t3.micro"
}

variable "engine_version" {
  description = "Redis engine version (optional)"
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
