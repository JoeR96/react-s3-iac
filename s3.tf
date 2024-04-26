provider "aws" {
  region = "eu-west-2"  # Ensure to set this to your AWS region
}

resource "aws_s3_bucket" "react_app" {
  bucket        = "${var.domain_name}-${var.env}"
  force_destroy = true

  # Enabling the website configuration directly within the bucket resource
  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

# Since you are allowing public access, it's crucial to configure the Public Access Block settings
resource "aws_s3_bucket_public_access_block" "react_app_access" {
  bucket = aws_s3_bucket.react_app.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# Define a bucket policy to allow public read access
resource "aws_s3_bucket_policy" "react_app_policy" {
  bucket = aws_s3_bucket.react_app.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.react_app.arn}/*"
      }
    ]
  })
}
