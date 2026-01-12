variable "app_name" { type = string }
variable "environment" { type = string }

variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }

variable "ecs_sg_id" {
  description = "ECS security group allowed to access DB"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "DB instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage (GB)"
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "Postgres engine version (optional)"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Dev friendly destroy"
  type        = bool
  default     = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
