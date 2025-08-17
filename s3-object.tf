resource "aws_s3_object" "object" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "index.html"
  content_type = "text/html"
  content = templatefile("${path.module}/frontend/index.html.tmpl", {
    api_url = local.api_url
  })
}
