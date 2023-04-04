terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "OAI" {
  comment = "OAI for Cloufront for the bucket - ${var.bucket_name}"
}

resource "aws_cloudfront_distribution" "cloudfront-dist" {
  origin {
    domain_name = var.domain_name
    origin_id   = var.origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.OAI.cloudfront_access_identity_path
    }
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Rollback cloudfront"
  http_version        = "http2"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.origin_id
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }
  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  tags = {
    env = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "oai_arn" {
  value = aws_cloudfront_origin_access_identity.OAI.iam_arn
}
