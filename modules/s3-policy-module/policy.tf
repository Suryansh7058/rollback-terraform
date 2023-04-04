terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}
data "aws_iam_policy_document" "cloudfront_OAI" {
  statement {
    sid = "Satement1"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetBucketLocation",
      "s3:ListBucket",
    ]

    resources = [
      "${var.s3_arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = [var.oai_iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.s3_arn
  policy = data.aws_iam_policy_document.cloudfront_OAI.json
}
