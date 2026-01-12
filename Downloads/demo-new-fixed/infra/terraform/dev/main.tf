locals {
  common_tags = merge(var.tags, {
    App         = var.app_name
    Environment = var.environment
  })
}
