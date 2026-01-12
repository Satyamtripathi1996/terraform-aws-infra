output "bucket_name" {
  value       = aws_s3_bucket.frontend.bucket
  description = "Frontend bucket name"
}

output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.frontend.domain_name
  description = "CloudFront domain name"
}

output "cloudfront_hosted_zone_id" {
  value       = aws_cloudfront_distribution.frontend.hosted_zone_id
  description = "CloudFront hosted zone id (for Route53 alias)"
}
