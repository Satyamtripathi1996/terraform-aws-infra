#############################################
# Docs module variables
# - Creates docs.<domain> static site (S3 + CloudFront)
# - Uses ACM certificate from us-east-1 (required by CloudFront)
#############################################

variable "app_name" {
  description = "Application name (used in resource names/tags)"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, prod, etc.)"
  type        = string
}

variable "domain_name" {
  description = "Root domain (example.com). Docs will be docs.<domain>"
  type        = string
}

variable "bucket_name" {
  description = "Optional custom docs bucket name"
  type        = string
  default     = null
}

variable "acm_certificate_arn" {
  description = "ACM cert ARN (must be us-east-1 for CloudFront)"
  type        = string
}

variable "enable_ipv6" {
  description = "Enable IPv6 for CloudFront distribution"
  type        = bool
  default     = true
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}

variable "spa_routing" {
  description = "If true, route 403/404 to index.html (SPA routing)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
