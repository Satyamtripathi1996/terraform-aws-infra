module "ecs" {
  source = "../modules/ecs"

  app_name    = var.app_name
  environment = var.environment
  aws_region  = var.aws_region

  private_subnet_ids = module.networking.private_subnet_ids
  ecs_sg_id          = module.networking.ecs_sg_id
  target_group_arn   = module.alb.target_group_arn

  container_name = "api"
  container_port = var.app_port

  image = "${module.ecr.repository_url}:${var.api_image_tag}"

  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam.ecs_task_role_arn

  environment_variables = [
    {
      name  = "S3_BUCKET"
      value = module.uploads_bucket.bucket_name
    },
    {
      name  = "DATABASE_URL"
      value = "postgresql://${module.rds.db_username}:${module.rds.db_password}@${module.rds.db_endpoint}/${module.rds.db_name}"
    },
    {
      name  = "CACHE_URL"
      value = module.elasticache.redis_connection_string
    },
    {
      name  = "FRONTEND_URL"
      value = "https://${var.domain_name}"
    }
  ]

  secrets = [] # add later if using Secrets Manager

  tags = local.common_tags
}
