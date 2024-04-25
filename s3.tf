resource "aws_s3_bucket" "react_app" {
  bucket = "${var.domain_name}-${var.env}"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  force_destroy = true

  # Enable public read access for all objects in the bucket
  # This sets the bucket policy to allow public read access
  acl = "public-read"
}
