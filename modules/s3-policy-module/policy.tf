terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}
# data "aws_iam_policy_document" "cloudfront_OAI" {
#   statement {
#     sid = "Accessed only by cloudfront"
#
#     actions = [
#       "s3:GetObject",
#       "s3:GetObjectAcl",
#       "s3:GetBucketLocation",
#       "s3:ListBucket",
#     ]
#
#     resources = [
#       "${var.s3_arn}/*"
#     ]
#
#     principals {
#       type        = "AWS"
#       identifiers = [var.oai_iam_arn]
#     }
#   }
# }

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions = ["s3:GetObject"]
    resources = [
      "${var.s3_arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = [var.oai_iam_arn]
    }
  }
}
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.s3_id
  policy = data.aws_iam_policy_document.s3_policy.json
}
