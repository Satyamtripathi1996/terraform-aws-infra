module "rds" {
  source = "../modules/rds"

  app_name    = var.app_name
  environment = var.environment

  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  ecs_sg_id          = module.networking.ecs_sg_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  tags = local.common_tags
}
