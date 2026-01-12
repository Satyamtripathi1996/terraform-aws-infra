module "elasticache" {
  source = "../modules/elasticache"

  app_name    = var.app_name
  environment = var.environment

  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  ecs_sg_id          = module.networking.ecs_sg_id

  tags = local.common_tags
}
