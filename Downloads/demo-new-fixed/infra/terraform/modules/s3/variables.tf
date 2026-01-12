variable "bucket_name" {
  description = "S3 bucket name (must be globally unique)"
  type        = string
}

variable "force_destroy" {
  description = "Allow terraform destroy even if objects exist (dev friendly)"
  type        = bool
  default     = true
}

variable "versioning" {
  description = "Enable versioning"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
