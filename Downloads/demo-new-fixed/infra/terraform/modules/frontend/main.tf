locals {
  final_bucket_name = coalesce(var.bucket_name, "${var.app_name}-frontend-${var.environment}")
}

resource "aws_s3_bucket" "frontend" {
  bucket        = local.final_bucket_name
  force_destroy = true

  tags = merge(var.tags, {
    Name        = local.final_bucket_name
    App         = var.app_name
    Environment = var.environment
  })
}

# Optional website config (helps index fallback)
resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  index_document { suffix = "index.html" }
  error_document { key = "index.html" }
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# CloudFront OAI
resource "aws_cloudfront_origin_access_identity" "frontend_oai" {
  comment = "OAI for frontend (${var.environment})"
}

# Allow only CloudFront to read S3 objects
resource "aws_s3_bucket_policy" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "AllowCloudFrontRead"
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.frontend.arn}/*"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.frontend_oai.iam_arn
        }
      }
    ]
  })
}

# Optional CloudFront Function (viewer-request)
resource "aws_cloudfront_function" "domain_router" {
  count = var.enable_domain_router_function ? 1 : 0

  name    = "domain-router-${var.environment}"
  runtime = "cloudfront-js-1.0"
  comment = "Optional: route requests based on domain"
  publish = true

  code = file("${path.module}/cloudfront-function.js")
}

resource "aws_cloudfront_distribution" "frontend" {
  enabled         = true
  is_ipv6_enabled = var.enable_ipv6

  default_root_object = "index.html"
  price_class         = var.price_class

  aliases = var.aliases

  origin {
    domain_name = aws_s3_bucket.frontend.bucket_regional_domain_name
    origin_id   = "frontend-origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.frontend_oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "frontend-origin"
    compress         = true

    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 604800

    dynamic "function_association" {
      for_each = var.enable_domain_router_function ? [1] : []
      content {
        event_type   = "viewer-request"
        function_arn = aws_cloudfront_function.domain_router[0].arn
      }
    }
  }

  # SPA routing fallback (optional)
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
    Name        = "${var.app_name}-frontend-cf-${var.environment}"
    App         = var.app_name
    Environment = var.environment
  })
}
