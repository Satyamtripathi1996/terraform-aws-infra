output "bucket_name" {
  value       = aws_s3_bucket.docs.bucket
  description = "Docs bucket name"
}

output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.docs.domain_name
  description = "Docs CloudFront domain name"
}

output "cloudfront_hosted_zone_id" {
  value       = aws_cloudfront_distribution.docs.hosted_zone_id
  description = "Docs CloudFront zone id"
}

output "docs_fqdn" {
  value       = "docs.${var.domain_name}"
  description = "Docs FQDN"
}
