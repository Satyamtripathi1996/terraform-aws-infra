########################################
# IAM (roles/policies needed by ECS, etc.)
########################################

module "iam" {
  source = "../modules/iam"

  app_name     = var.app_name
  environment  = var.environment

  s3_bucket_arns = [
    module.uploads_bucket.bucket_arn
  ]

  secrets_arns = var.secrets_arns

  tags = local.common_tags
}
