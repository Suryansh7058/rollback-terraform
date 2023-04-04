terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

module "rollback-s3" {
  source         = "./modules/s3-module/"
  s3_bucket_name = local.s3_bucket_name
}

module "cloudfront" {
  source      = "./modules/cdn-module/"
  bucket_name = local.s3_bucket_name
  domain_name = module.rollback-s3.aws_s3_bucket.bucket.bucket_regional_domain_name
  origin_id   = var.origin_id
}

module "s3policy" {
  source      = "./modules/s3-policy-module/"
  oai_iam_arn = module.cloudfront.aws_cloudfront_origin_access_identity.OAI.iam_arn
  s3_arn      = module.rollback-s3.aws_s3_bucket.bucket.bucket_regional_domain_name
}
