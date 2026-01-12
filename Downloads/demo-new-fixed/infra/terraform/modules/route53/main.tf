resource "aws_route53_zone" "this" {
  count = var.create_zone ? 1 : 0
  name  = var.domain_name

  tags = merge(var.tags, {
    Name = var.domain_name
  })
}

locals {
  hosted_zone_id = var.create_zone ? aws_route53_zone.this[0].zone_id : var.zone_id
}

########################################
# API record -> ALB
########################################
resource "aws_route53_record" "api" {
  count   = var.create_api_record ? 1 : 0
  zone_id = local.hosted_zone_id
  name    = "api.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.api_alb_dns_name
    zone_id                = var.api_alb_zone_id
    evaluate_target_health = true
  }
}

########################################
# Root + App -> Frontend CloudFront
########################################
resource "aws_route53_record" "root_frontend" {
  count   = var.create_frontend_records ? 1 : 0
  zone_id = local.hosted_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.frontend_cloudfront_domain_name
    zone_id                = var.frontend_cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "app_frontend" {
  count   = var.create_frontend_records ? 1 : 0
  zone_id = local.hosted_zone_id
  name    = "app.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.frontend_cloudfront_domain_name
    zone_id                = var.frontend_cloudfront_zone_id
    evaluate_target_health = false
  }
}

########################################
# Docs -> Docs CloudFront
########################################
resource "aws_route53_record" "docs_frontend" {
  count   = var.create_docs_record ? 1 : 0
  zone_id = local.hosted_zone_id
  name    = "docs.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.docs_cloudfront_domain_name
    zone_id                = var.docs_cloudfront_zone_id
    evaluate_target_health = false
  }
}
