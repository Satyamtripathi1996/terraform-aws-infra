# CloudFront cert must be in us-east-1
module "acm_cloudfront" {
  source = "../modules/acm"

  providers = { aws = aws.us_east_1 }

  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  hosted_zone_id            = module.route53_zone.hosted_zone_id
  tags                      = local.common_tags
}

# ALB cert must be in same region as ALB (your aws_region)
module "acm_alb" {
  source = "../modules/acm"

  domain_name    = "api.${var.domain_name}"
  hosted_zone_id = module.route53_zone.hosted_zone_id
  tags           = local.common_tags
}
