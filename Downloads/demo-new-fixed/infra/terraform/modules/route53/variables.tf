variable "create_zone" {
  description = "Whether to create a hosted zone"
  type        = bool
  default     = true
}

variable "zone_id" {
  description = "Existing zone id if create_zone=false"
  type        = string
  default     = null
}

variable "domain_name" {
  description = "Root domain name (example.com)"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

# API -> ALB
variable "create_api_record" {
  description = "Create api.<domain> record"
  type        = bool
  default     = false
}

variable "api_alb_dns_name" {
  description = "ALB DNS name for API alias"
  type        = string
  default     = null
}

variable "api_alb_zone_id" {
  description = "ALB zone id for API alias"
  type        = string
  default     = null
}

# Root + app -> Frontend CloudFront
variable "create_frontend_records" {
  description = "Create root + app records to frontend CloudFront"
  type        = bool
  default     = false
}

variable "frontend_cloudfront_domain_name" {
  description = "CloudFront domain name for frontend"
  type        = string
  default     = null
}

variable "frontend_cloudfront_zone_id" {
  description = "CloudFront hosted zone id for frontend"
  type        = string
  default     = null
}

# Docs -> Docs CloudFront
variable "create_docs_record" {
  description = "Create docs record to docs CloudFront"
  type        = bool
  default     = false
}

variable "docs_cloudfront_domain_name" {
  description = "CloudFront domain name for docs"
  type        = string
  default     = null
}

variable "docs_cloudfront_zone_id" {
  description = "CloudFront hosted zone id for docs"
  type        = string
  default     = null
}
