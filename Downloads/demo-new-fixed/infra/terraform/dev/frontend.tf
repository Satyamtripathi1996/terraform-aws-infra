locals {
  app_fqdn = "app.${var.domain_name}"
}

module "frontend" {
  source = "../modules/frontend"

  providers = { aws = aws.us_east_1 }   # added this line

  app_name     = var.app_name
  environment  = var.environment
  bucket_name  = var.frontend_bucket_name

  # Root + app subdomain on SAME distribution
  aliases = [
    var.domain_name,
    local.app_fqdn
  ]

  # IMPORTANT: CloudFront ACM certificate must be from us-east-1 (your acm_cloudfront module)
  acm_certificate_arn = module.acm_cloudfront.certificate_arn

  enable_ipv6  = var.enable_ipv6
  price_class  = var.price_class

  spa_routing                  = true
  enable_domain_router_function = false

  tags = local.common_tags
}