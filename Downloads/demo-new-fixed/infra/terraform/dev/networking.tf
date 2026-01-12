module "networking" {
  source = "../modules/networking"

  app_name    = var.app_name
  environment = var.environment

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  app_port = var.app_port

  tags = local.common_tags
}
