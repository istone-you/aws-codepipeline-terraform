variable "access_key" {}

variable "secret_key" {}

variable "region" {
  default = "ap-northeast-1"
}

variable "docker_sercrets_arn" {}

data "aws_caller_identity" "current" {}
