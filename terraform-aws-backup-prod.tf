module "terraform_aws_backup_prod_pipeline" {
  source = "./modules/pipeline_terraform"

  project_name             = "terraform-aws-backup-prod"
  codecommit_repo_name     = "terraform-aws-backup-prod"
  region                   = var.region
  artifacts_bucket         = var.artifacts_bucket_name
  artifacts_bucket_key_arn = var.artifacts_bucket_key_arn
}
