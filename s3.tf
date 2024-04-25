resource "aws_s3_bucket" "react_app" {
  bucket = "${var.domain_name}-${var.env}"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  force_destroy = true
}

resource "aws_s3_bucket_policy" "react_app_policy" {
  bucket = aws_s3_bucket.react_app.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = ["s3:GetObject"],
        Effect    = "Allow",
        Principal = "*",
        Resource  = "${aws_s3_bucket.react_app.arn}/*"
      }
    ]
  })
}
