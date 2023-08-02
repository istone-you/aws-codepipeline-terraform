
variable "project_name" {
  type = string
}

variable "codecommit_repo_name" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "extract" {
  type = bool
}

variable "object_key" {
  type    = string
  default = null
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

variable "ansible_playbook_bucket_name" {
  type = string
}

data "aws_caller_identity" "current" {}
