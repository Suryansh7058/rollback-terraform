variable "project_name" {
  type    = string
  default = "rollback-s3-bucket-new"
}

variable "environment" {
  type    = string
  default = "prd"
}

variable "origin_id" {
  type    = string
  default = "cloudfront-rollback-s3"
}

locals {
  s3_bucket_name = "${var.project_name}-${var.environment}"
}
