variable "app_name" {
  description = "App name"
  type        = string
}

variable "environment" {
  description = "Environment (dev/prod)"
  type        = string
}

variable "s3_bucket_arns" {
  description = "S3 bucket ARNs the app should access"
  type        = list(string)
  default     = []
}

variable "secrets_arns" {
  description = "Secrets Manager ARNs the task should read"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
