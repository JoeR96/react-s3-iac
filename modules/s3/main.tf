resource "aws_s3_bucket" "react_app" {
    bucket = var.bucket_name
    acl    = "public-read"

    website {
        index_document = "index.html"
        error_document = "error.html"
    }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.react_app.id
    policy = data.aws_iam_policy_document.bucket_policy.json
}
