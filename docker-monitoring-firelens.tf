module "docker_monitoring_firelens_pipeline" {
  source = "./modules/pipeline_docker"

  project_name             = "docker-monitoring-firelens"
  codecommit_repo_name     = "docker-monitoring-firelens"
  ecr_repo_name            = "monitoring-firelens"
  deploy_script            = "echo 'Docker push successful! Image uploaded to the repository.'"
  region                   = var.region
  artifacts_bucket         = var.artifacts_bucket_name
  artifacts_bucket_key_arn = var.artifacts_bucket_key_arn
  docker_sercrets_arn      = var.docker_sercrets_arn
}


