variable "app_name" { type = string }
variable "environment" { type = string }

variable "bucket_name" {
  description = "Optional custom bucket name (must be globally unique)"
  type        = string
  default     = null
}

variable "aliases" {
  description = "CloudFront alternate domain names (root + app)"
  type        = list(string)
}

variable "acm_certificate_arn" {
  description = "ACM cert ARN (must be in us-east-1 for CloudFront)"
  type        = string
}

variable "enable_ipv6" {
  type    = bool
  default = true
}

variable "price_class" {
  type    = string
  default = "PriceClass_100"
}

variable "spa_routing" {
  description = "SPA routing fallback (403/404 -> /index.html)"
  type        = bool
  default     = true
}

variable "enable_domain_router_function" {
  description = "Optional CloudFront Function (viewer-request)"
  type        = bool
  default     = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
