variable "access_key" {}

variable "secret_key" {}

variable "region" {
  default = "ap-northeast-1"
}

variable "docker_sercrets_arn" {}

variable "ansible_playbook_bucket_name" {}

variable "serverless_deploy_bucket_name" {}

data "aws_caller_identity" "current" {}
