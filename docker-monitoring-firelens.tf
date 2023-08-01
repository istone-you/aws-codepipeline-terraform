module "docker_monitoring_firelens_pipeline" {
  source = "./modules/pipeline_docker_deploy"

  project_name             = "docker-monitoring-firelens"
  codecommit_repo_name     = "docker-monitoring-firelens"
  ecr_repo_name            = "monitoring-firelens"
  deploy_script            = "echo 'Docker push successful! Image uploaded to the repository.'"
  region                   = var.region
  artifacts_bucket         = aws_s3_bucket.artifacts_bucket.bucket
  artifacts_bucket_arn     = aws_s3_bucket.artifacts_bucket.arn
  artifacts_bucket_key_arn = aws_kms_key.artifacts_bucket_key.arn
  docker_sercrets_arn      = var.docker_sercrets_arn
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  ]
}


