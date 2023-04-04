resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name
}
