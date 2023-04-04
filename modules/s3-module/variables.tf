locals {
  bucket_name = "${var.project_name}-${var.environment}"
}

variable "project_name" {
  description = "Name of the project. This will be added to all resource names."
  type        = string
}

variable "environment" {
  description = "Name of the environment. Will be added to all resource names"
  type        = string
}
