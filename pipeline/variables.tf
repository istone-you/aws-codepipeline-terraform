variable "access_key" {}

variable "secret_key" {}

variable "region" {
  default = "ap-northeast-1"
}

variable "artifacts_bucket_name" {}

variable "artifacts_bucket_key_name" {}

variable "codecommit_repo_name" {}

data "aws_caller_identity" "current" {}
