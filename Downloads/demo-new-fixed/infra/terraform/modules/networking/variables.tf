variable "app_name" {
  description = "App name"
  type        = string
}

variable "environment" {
  description = "Environment (dev/prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "app_port" {
  description = "Port exposed by ECS tasks (ALB forwards to this port)"
  type        = number
  default     = 8000
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
