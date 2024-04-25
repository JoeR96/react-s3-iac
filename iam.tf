resource "aws_iam_policy" "acm_policy" {
  name        = "ACMCertificateRequestPolicy"
  description = "Allows requesting ACM certificates"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "acm:RequestCertificate",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "route53_policy" {
  name        = "Route53CreateHostedZonePolicy"
  description = "Allows creation of Route 53 hosted zones"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "route53:CreateHostedZone",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "s3_policy" {
  name        = "S3FullAccessPolicy"
  description = "Allows full access to a specific S3 bucket"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketAcl",
                "s3:PutBucketAcl",
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:CreateBucket",
                "s3:DeleteBucket",
                "s3:ListBucket",
                "s3:ListBucketVersions",
                "s3:GetBucketPolicy",
                "s3:PutBucketPolicy",
                "s3:DeleteBucketPolicy"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.react_app.bucket}",
                "arn:aws:s3:::${aws_s3_bucket.react_app.bucket}/*"
            ]
        }
    ]
}
EOF
}

//these policies are coded to my operation-stacked user atm, in the next phase we will move roles to be purely IAC
resource "aws_iam_user_policy_attachment" "acm_attachment" {
  user       = "operation-stacked"
  policy_arn = aws_iam_policy.acm_policy.arn
}

resource "aws_iam_user_policy_attachment" "route53_attachment" {
  user       = "operation-stacked"
  policy_arn = aws_iam_policy.route53_policy.arn
}

resource "aws_iam_user_policy_attachment" "s3_attachment" {
  user       = "operation-stacked"
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_user_policy_attachment" "s3_attachment" {
  user       = "operation-stacked"
  policy_arn = aws_iam_policy.s3_policy.arn
}
