module "alb" {
  source = "../modules/alb"

  app_name    = var.app_name
  environment = var.environment

  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  alb_sg_id         = module.networking.alb_sg_id

  certificate_arn   = module.acm_alb.certificate_arn
  app_port          = var.app_port
  health_check_path = var.health_check_path

  tags = local.common_tags
}
