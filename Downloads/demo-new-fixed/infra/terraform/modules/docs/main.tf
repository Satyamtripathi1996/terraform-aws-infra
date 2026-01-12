locals {
  final_bucket_name = coalesce(var.bucket_name, "${var.app_name}-docs-${var.environment}")
  docs_fqdn         = "docs.${var.domain_name}"
}

resource "aws_s3_bucket" "docs" {
  bucket        = local.final_bucket_name
  force_destroy = true

  tags = merge(var.tags, {
    Name        = local.final_bucket_name
    App         = var.app_name
    Environment = var.environment
  })
}

resource "aws_s3_bucket_website_configuration" "docs" {
  bucket = aws_s3_bucket.docs.id

  index_document { suffix = "index.html" }
  error_document { key = "index.html" }
}

resource "aws_s3_bucket_public_access_block" "docs" {
  bucket = aws_s3_bucket.docs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_identity" "docs_oai" {
  comment = "OAI for ${local.docs_fqdn} docs (${var.environment})"
}

resource "aws_s3_bucket_policy" "docs" {
  bucket = aws_s3_bucket.docs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "AllowCloudFrontRead"
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.docs.arn}/*"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.docs_oai.iam_arn
        }
      }
    ]
  })
}

resource "aws_cloudfront_distribution" "docs" {
  enabled         = true
  is_ipv6_enabled = var.enable_ipv6

  default_root_object = "index.html"
  price_class         = var.price_class

  aliases = [local.docs_fqdn]

  origin {
    domain_name = aws_s3_bucket.docs.bucket_regional_domain_name
    origin_id   = "docs-origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.docs_oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "docs-origin"
    compress         = true

    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 604800
  }

  dynamic "custom_error_response" {
    for_each = var.spa_routing ? [1] : []
    content {
      error_code         = 403
      response_code      = 200
      response_page_path = "/index.html"
    }
  }

  dynamic "custom_error_response" {
    for_each = var.spa_routing ? [1] : []
    content {
      error_code         = 404
      response_code      = 200
      response_page_path = "/index.html"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  tags = merge(var.tags, {
    Name        = "${var.app_name}-docs-cf-${var.environment}"
    App         = var.app_name
    Environment = var.environment
  })
}
