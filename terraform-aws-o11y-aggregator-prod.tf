module "terraform_aws_o11y_aggregator_prod_pipeline" {
  source = "./modules/pipeline_terraform"

  project_name             = "terraform-aws-o11y-aggregator-prod"
  codecommit_repo_name     = "terraform-aws-o11y-aggregator-prod"
  region                   = var.region
  artifacts_bucket         = var.artifacts_bucket_name
  artifacts_bucket_key_arn = var.artifacts_bucket_key_arn
}
