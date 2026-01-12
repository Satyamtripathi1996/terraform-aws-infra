module "docs" {
  source = "../modules/docs"

  providers = { aws = aws.us_east_1 }   # added  this line

  app_name    = var.app_name
  environment = var.environment
  domain_name = var.domain_name

  bucket_name = var.docs_bucket_name     # added  this line

  acm_certificate_arn = module.acm_cloudfront.certificate_arn
  spa_routing         = true

  tags = local.common_tags
}
