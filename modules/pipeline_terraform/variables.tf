
variable "region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "codecommit_repo_name" {
  type = string
}

variable "ecr_repo_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "artifacts_bucket" {
  type = string
}

variable "artifacts_bucket_arn" {
  type = string
}

variable "artifacts_bucket_key_arn" {
  type = string
}

variable "managed_policy_arns" {
  type = set(string)
}

data "aws_caller_identity" "current" {}
