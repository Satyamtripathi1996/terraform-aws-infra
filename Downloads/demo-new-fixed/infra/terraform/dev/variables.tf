variable "app_name" {
  description = "Application name"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev/prod/etc)"
  type        = string
}

variable "aws_region" {
  description = "AWS region for primary resources"
  type        = string
}

variable "domain_name" {
  description = "Root domain (example.com)"
  type        = string
}

variable "app_port" {
  description = "Container port for the API"
  type        = number
}

variable "health_check_path" {
  description = "ALB health check path"
  type        = string
  default     = "/health"
}

variable "api_image_tag" {
  description = "Docker image tag for the API"
  type        = string
  default     = "latest"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "db_name" {
  description = "RDS DB name"
  type        = string
}

variable "db_username" {
  description = "RDS master username"
  type        = string
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "secrets_arns" {
  description = "Secrets Manager ARNs"
  type        = list(string)
  default     = []
}

variable "uploads_bucket_name" {
  description = "Optional custom uploads bucket name"
  type        = string
  default     = null
}

variable "create_hosted_zone" {
  description = "Create Route53 hosted zone?"
  type        = bool
  default     = true
}

variable "existing_zone_id" {
  description = "Existing hosted zone ID (if create_hosted_zone = false)"
  type        = string
  default     = null
}

variable "frontend_bucket_name" {
  description = "Optional custom S3 bucket name for frontend (must be globally unique). If null, module will auto-name."
  type        = string
  default     = null
}

variable "enable_ipv6" {
  description = "Enable IPv6 for CloudFront distributions"
  type        = bool
  default     = true
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
variable "docs_bucket_name" {
  description = "Optional custom S3 bucket name for docs (must be globally unique). If null, module will auto-name."
  type        = string
  default     = null
}

