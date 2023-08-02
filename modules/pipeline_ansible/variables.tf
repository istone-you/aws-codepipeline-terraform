
variable "project_name" {
  type = string
}

variable "codecommit_repo_name" {
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

variable "ansible_playbook_bucket_name" {
  type = string
}

variable "managed_policy_arns" {
  type = set(string)
}

data "aws_caller_identity" "current" {}
