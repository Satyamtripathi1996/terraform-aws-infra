module "ecr" {
  source = "../modules/ecr"

  repository_name = "${var.app_name}-${var.environment}-api"
  tags            = local.common_tags
}
