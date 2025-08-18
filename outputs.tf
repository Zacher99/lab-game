output "website_url" {
  description = "Static website URL hosted on s3"
  value       = "http://${aws_s3_bucket.bucket.bucket}.s3-website.${var.region}.amazonaws.com/"
  sensitive   = false
}
