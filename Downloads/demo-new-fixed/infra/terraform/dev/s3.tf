module "uploads_bucket" {
  source = "../modules/s3"

  bucket_name   = var.uploads_bucket_name
  force_destroy = true
  versioning    = false
  tags          = local.common_tags
}
