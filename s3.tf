resource "aws_s3_bucket" "react_app" {
  bucket = "${var.domain_name}-${var.env}"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  force_destroy = true
}
