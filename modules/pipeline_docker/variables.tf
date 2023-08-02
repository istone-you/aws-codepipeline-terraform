
variable "project_name" {
  type = string
}

variable "codecommit_repo_name" {
  type = string
}

variable "ecr_repo_name" {
  type = string
}

variable "deploy_script" {
  type = string
}

variable "region" {
  type = string
}

variable "artifacts_bucket" {
  type = string
}

variable "artifacts_bucket_key_arn" {
  type = string
}

variable "docker_sercrets_arn" {
  type = string
}

data "aws_caller_identity" "current" {}
